<template>
    <v-container fluid class="py-10">
                <v-card>
                    <v-sheet class="pa-4" color="">
                        <h1 class="text-h5 text-center font-weight-bold bg-maroon" >สถานะการประเมินของผู้รับการประเมิน</h1>
                    </v-sheet>
                    <v-card-text>
                       รายชื่อผู้รับการประเมิน
                        <v-table>
                            <thead>
                                <tr>
                                    <th class="text-center border">ลำดับ</th>
                                    <th class="text-center border">ผู้รับการประเมิน</th>
                                    <th class="text-center border">วันที่ออกแบบประเมิน</th>
                                    <th class="text-center border">รอบการประเมิน</th>
                                    <th class="text-center border">สถานะการประเมิน</th>
                                    <!-- <th class="text-center border">รายละเอียด</th> -->
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(items,index) in result" :keys="items.id_eva">
                                    <td class="text-center border">{{ index+1 }}</td>
                                    <td class="text-center border">{{ items.first_name }} {{ items.last_name }}</td>
                                    <td class="text-center border">{{ items.day_eva }}</td>
                                    <td class="text-center border">รอบการประเมินที่ {{ items.round_sys }} ปี {{ items.year_sys }}</td>
                                    <td class="text-center border">
                                        <v-btn class="text-white" size="small" :color="bg(items.status_eva)">{{ items.status_eva === 1 ? 'ประเมินตนเอง' : items.status_eva === 2 ? 'กรรมการประเมิน' : 'ปิด' }}</v-btn>
                                    </td>
                                    <!-- <td class="text-center border">
                                        <v-btn class="text-white" size="small" color="success" @click="go(items.id_eva)">รายละเอียด</v-btn>
                                    </td> -->
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

const fetch = async () => {
    try{    
        const res = await axios.get(`${staff}/eva`,{headers:{Authorization: `Bearer ${token}`}})
        result.value = res.data
    }catch(err){
        console.error('Error Fetching',err)
    }
}

const bg = (status_eva:string) => {
    if(status_eva === 1) return 'error'
    if(status_eva === 2) return 'warning'
    if(status_eva === 3) return 'success'
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