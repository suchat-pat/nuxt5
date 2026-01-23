<template>
    <v-container fluid class="py-10">
                <v-card>
                    <v-sheet class="pa-4" color="">
                        <h1 class="text-h5 text-center font-weight-bold bg-maroon" >จัดการหัวข้อการประเมิน</h1>
                    </v-sheet>
                    <v-card-text>
                        <v-form @submit.prevent="saveMember">
                            <v-row>
                                <v-col cols="12" md="12">
                                    <v-text-field label="ชื่อหัวข้อการประเมิน" v-model="form.name_topic" :error-messages="error.name_topic" />
                                </v-col>
                                <v-row>
                                    <v-col cols="12" md="6" >
                                       <v-btn type="submit" color="blue" block>{{ form.id_topic ? 'อัปเดต' : 'บันทึก' }}</v-btn> 
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
                                    <th class="text-center border">หัวข้อการประเมิน</th>
                                    <th class="text-center border">จัดการ</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(items,index) in result" :keys="items.id_topic">
                                    <td class="text-center border">{{ index+1 }}</td>
                                    <td class="text-center border">{{ items.name_topic }}</td>
                                    <td class="text-center border">
                                        <v-btn class="text-white" size="small" color="warning" @click="edit(items)">แก้ไข</v-btn>&nbsp;
                                        <v-btn class="text-white" size="small" color="error" @click="del(items.id_topic)">ลบ</v-btn>
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

const form = ref({
    id_topic: null,
    name_topic:'',
})

const reset = () => {
    form.value = {
        id_topic: null,
        name_topic:'',
    }
}

const edit = (items:any) => {
    form.value = {...items}
}


const error = ref<Record<string,string>>({})

function validateForm(){
    error.value = {}
    const f = form.value
    if(!f.name_topic.trim())error.value.name_topic='กรุณากรอกชื่อหัวข้อ'
    return Object.keys(error.value).length === 0
}

const fetch = async () => {
    try{
        const res = await axios.get(`${staff}/topic`,{headers:{Authorization: `Bearer ${token}`}})
        result.value = res.data
    }catch(err){
        console.error('Error Fetching',err)
    }
}

const saveMember = async () =>{
    if(!validateForm())return
    try{
        form.value.id_topic
            ? await axios.put(`${staff}/topic/${form.value.id_topic}`,form.value,{headers:{Authorization: `Bearer ${token}`}})
            : await axios.post(`${staff}/topic`,form.value,{headers:{Authorization: `Bearer ${token}`}})
        await fetch()
        await reset()
        alert('ทำรายการ')
    }catch(err){
        console.error('Error!!',err)
    }
}

const del = async (id_topic:number) => {
    try{
        if(!confirm('ต้องการลบใช่หรือไม่?')) return
        await axios.delete(`${staff}/topic/${id_topic}`,{headers:{Authorization: `Bearer ${token}`}})
        await reset()
        await fetch()
    }catch(err){
        console.error('Error Delete',err)
    }
}

onMounted(fetch)
</script>

<style scoped>
.bg-maroon{
    color: #7d0c14;
}
</style>