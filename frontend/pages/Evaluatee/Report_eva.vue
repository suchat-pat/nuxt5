<template>
    <v-container>
        <c-row>
            <v-col cols="12">
                <v-form v-if="user.status_eva === 2 || user.status_eva === 3">
                    <v-h1 class="text-h5 font-weight-bold">รายงานผลคะแนน</v-h1>
                    <v-card class="pa-2 mt-2">
                        <p>ชื่อ - นามกสุล : {{ user.first_name }} {{ user.last_name }}</p>
                        <p>รอบประเมิน : {{ user.round_sys }} ปี {{ user.year_sys }}</p>
                    </v-card>
                    <v-row v-for="(topic,index1) in topics" :key="topic.id_topic" class="mt-2">
                        <v-col cols="12">
                            {{ index1+1 }}.{{ topic.name_topic }}
                            <v-table class="table">
                                <tr>
                                    <th class="pa-2 border bg-grey text-black" style="width: 10%;">ตัวชี้วัด</th>
                                    <th class="pa-2 border bg-grey text-black" style="width: 10%;">รายละเอียด</th>
                                    <th class="pa-2 border bg-grey text-black" style="width: 10%;">น้ำนักคะแนน</th>
                                    <th class="pa-2 border bg-grey text-black" style="width: 10%;">คะแนนเต็ม</th>
                                    <th class="pa-2 border bg-grey text-black" style="width: 10%;">ประธาน</th>
                                    <th class="pa-2 border bg-grey text-black" style="width: 10%;">กรรมการ</th>
                                    <th class="pa-2 border bg-grey text-black" style="width: 10%;">เลขา</th>
                                    <th class="pa-2 border bg-grey text-black" style="width: 10%;">คะแนนที่ได้</th>
                                </tr>
                                <tr v-for="indicate in topic.indicates" :key="indicate.id_indicate">
                                    <td class="border text-center pa-2">{{ indicate.name_indicate }}</td>
                                    <td class="border text-center pa-2">{{ indicate.detail_indicate }}</td>
                                    <td class="border text-center pa-2">{{ indicate.point_indicate }}</td>
                                    <td class="border text-center pa-2">{{ indicate.point_indicate*4 }}</td>
                                    <td class="border text-center pa-2">{{ scores[indicate.id_indicate]?.a ?? 'รอประธานประเมิน' }}</td>
                                    <td class="border text-center pa-2">{{ scores[indicate.id_indicate]?.b ?? 'รอกรรมการประเมิน' }}</td>
                                    <td class="border text-center pa-2">{{ scores[indicate.id_indicate]?.c ?? 'รอเลขาประเมิน' }}</td>
                                    <td class="border text-center pa-2">
                                        {{ (((scores[indicate.id_indicate]?.a ?? 0)+(scores[indicate.id_indicate]?.b ?? 0)+(scores[indicate.id_indicate]?.c ?? 0))/3).toFixed(2) }}
                                    </td>
                                </tr>
                            </v-table>
                        </v-col>
                    </v-row>
                    <div class="mt-4 text-end">
                        <v-card class="pa-2" color="success">คะแนนรวมสุทธิ : {{ totalScore.toFixed(2) }} คะแนน</v-card>
                    </div>
                    
                    <div class="mt-4">
                        <v-card class="pa-2 text-center">
                            <v-row>
                                <v-col cols="4" v-for="commit in commits" :key="commit.id_commit">
                                    <img :src="`http://localhost:3001/uploads/signature/${commit.signature}`" style="width: 20%;" ><br>({{ commit.first_name }} {{ commit.last_name }})<br>{{ commit.level_commit }}
                                </v-col>
                            </v-row>
                        </v-card>
                    </div>
                    <div class="text-center mt-5">
                        <v-btn @click="printScore" color="blue" class="noP">พิมพ์</v-btn>
                    </div>
                </v-form>
                <v-alert v-else-if="user.status_eva === 1" type="info">คุณยังไม่ได้ประเมินตนเอง</v-alert>
                <v-alert v-else type="warning">คุณยังไม่มีแบบประเมิน</v-alert>
            </v-col>
        </c-row>
    </v-container>
</template>

<script setup lang="ts">
import axios from 'axios'
import {eva} from '../../API/base'

const user = ref<any>({})
const topics = ref([])
const scores = ref([])
const totalScore = ref(0)
const commits = ref([])

const printScore = async () =>{
    window.print()
}

const fetchUser = async () =>{
    try{
        const token = localStorage.getItem('token')
        const res = await axios.get(`${eva}/score_commit/user`,{headers:{Authorization:`Bearer ${token}`}})
        user.value = res.data
    }catch(err){
        console.error("Error Get User!",err)
    }
}
const fetchTopic = async () =>{
    try{
        const token = localStorage.getItem('token')
        const res = await axios.get(`${eva}/score_commit/indicate`,{headers:{Authorization:`Bearer ${token}`}})
        topics.value = res.data
    }catch(err){
        console.error("Error Get User!",err)
    }
}

const fetchCommit = async () =>{
    try{
        const token = localStorage.getItem('token')
        const res = await axios.get(`${eva}/score_commit/commits`,{headers:{Authorization:`Bearer ${token}`}})
        commits.value = res.data
        console.log('commit:',commits.value)
    }catch(err){
        console.error("Error Get User!",err)
    }
}

const fetchScore = async () =>{
    try{
        const token = localStorage.getItem('token')
        const res = await axios.get(`${eva}/score_commit/scores`,{headers:{Authorization:`Bearer ${token}`}})
        scores.value = res.data.scores
        totalScore.value = res.data.totalScore
    }catch(err){
        console.error("Error Get Score!",err)
    }
}

onMounted(async () =>{
    await Promise.all([fetchTopic(),fetchUser(),fetchScore(),fetchCommit()])
})

</script>

<style scoped>
@media print {
    .v-btn,.noP{
        display: none;
    }
}
</style>