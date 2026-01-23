<template>
    <v-container fluid class="py-10">
                <v-card>
                    <v-sheet class="pa-4" color="">
                        <h1 class="text-h5 text-center font-weight-bold bg-maroon" >จัดการแบบประเมิน</h1>
                    </v-sheet>
                    <v-card-text>
                        <v-form @submit.prevent="saveMember">
                            <v-row>
                                <v-col cols="12" md="6">
                                    <v-select label="ผู้รับการประเมิน" :items="member.map(m => ({title:`${m.first_name} ${m.last_name}`,value: m.id_member}))" v-model="form.id_member" />
                                </v-col>
                                <v-col cols="12" md="6">
                                    <v-text-field label="วันที่ออกแบบประเมิน" type="date" v-model="form.day_eva" />
                                </v-col>
                                <v-col cols="12" md="12">
                                    <v-select label="รอบการประเมิน" :items="sys.map(s => ({title:`รอบการประเมินที่ ${s.round_sys} ปี ${s.year_sys}`,value: s.id_sys}))" v-model="form.id_sys" />
                                </v-col>
                                <v-row>
                                    <v-col cols="12" md="6" >
                                       <v-btn type="submit" color="blue" block>{{ form.id_eva ? 'อัปเดต' : 'บันทึก' }}</v-btn> 
                                    </v-col>
                                    <v-col cols="12" md="6" >
                                       <v-btn type="reset" color="#7d0c14" block>ยกเลิก</v-btn> 
                                    </v-col>
                                </v-row>
                            </v-row>
                        </v-form>
                        <br><br>
                        <v-table>
                            <thead>
                                <tr>
                                    <th class="text-center border">ลำดับ</th>
                                    <th class="text-center border">ผู้รับการประเมิน</th>
                                    <th class="text-center border">วันที่ออกแบบประเมิน</th>
                                    <th class="text-center border">รอบการประเมิน</th>
                                    <th class="text-center border">สถานะการประเมิน</th>
                                    <th class="text-center border">จัดการ</th>
                                    <th class="text-center border">เพิ่มกรรมการ</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(items,index) in result" :keys="items.id_eva">
                                    <td class="text-center border">{{ index+1 }}</td>
                                    <td class="text-center border">{{ items.first_name }} {{ items.last_name }}</td>
                                    <td class="text-center border">{{ items.day_eva }}</td>
                                    <td class="text-center border">รอบการประเมินที่ {{ items.round_sys }} ปี {{ items.year_sys }}</td>
                                    <td class="text-center border">{{ items.status_eva === 1 ? 'ประเมินตนเอง' : items.status_eva === 2 ? 'กรรมการประเมิน' : 'ปิด' }}</td>
                                    <td class="text-center border">
                                        <v-btn class="text-white" size="small" color="warning" @click="edit(items)">แก้ไข</v-btn>&nbsp;
                                        <v-btn class="text-white" size="small" color="error" @click="del(items.id_eva)">ลบ</v-btn>
                                    </td>
                                    <td class="text-center border">
                                        <v-btn class="text-white" size="small" color="success" @click="go(items.id_eva)">เพิ่มกรรมการ</v-btn>
                                    </td>
                                </tr>
                                <tr class></tr>
                            </tbody>
                        </v-table>
                    </v-card-text>
                </v-card>
    </v-container>
</template>

<script setup lang="ts">
import axios from 'axios'
import {api,staff} from '../API/base'

const token = process.client ? localStorage.getItem('token') : null

const result = ref([])
const member = ref([])
const sys = ref([])

const form = ref({
    id_eva: null,
    id_member: '',
    id_sys: '',
    day_eva: '',
})

const reset = () => {
    form.value = {
      id_eva: null,
    id_member: '',
    id_sys: '',
    day_eva: '',
    }
}

const edit = (items:any) => {
    form.value = {...items}
}

const fetch = async () => {
    try{
        
        const m = await axios.get(`${staff}/member/eva`,{headers:{Authorization: `Bearer ${token}`}})
        member.value = m.data
        
        const s = await axios.get(`${staff}/eva/round`,{headers:{Authorization: `Bearer ${token}`}})
        sys.value = s.data
        
        const res = await axios.get(`${staff}/eva`,{headers:{Authorization: `Bearer ${token}`}})
        result.value = res.data
    }catch(err){
        console.error('Error Fetching',err)
    }
}

const saveMember = async () =>{
    try{
        form.value.id_eva
            ? await axios.put(`${staff}/eva/${form.value.id_eva}`,form.value,{headers:{Authorization: `Bearer ${token}`}})
            : await axios.post(`${staff}/eva`,form.value,{headers:{Authorization: `Bearer ${token}`}})
        await fetch()
        await reset()
        alert('ทำรายการ')
    }catch(err){
        console.error('Error!!',err)
    }
}

const del = async (id_eva:number) => {
    try{
        if(!confirm('ต้องการลบใช่หรือไม่?')) return
        await axios.delete(`${staff}/eva/${id_eva}`,{headers:{Authorization: `Bearer ${token}`}})
        await reset()
        await fetch()
    }catch(err){
        console.error('Error Delete',err)
    }
}

const go = (id_eva:number) => {
    navigateTo({path:`Eva_commit-${id_eva}`})
}

onMounted(fetch)
</script>

<style scoped>
.bg-maroon{
    color: #7d0c14;
}
</style>