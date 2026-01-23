<template>
    <v-container fluid class="py-10">
                <v-card>
                    <v-sheet class="pa-4" color="">
                        <h1 class="text-h5 text-center font-weight-bold bg-maroon" >Dashboard - Staff</h1>
                    </v-sheet>
                    <v-card-text>
                        <!-- content -->
                         <v-row>
                            <v-col cols="12" md="4" v-for="b in box" key="b">
                                <v-card elevation="3" class="pa-4">
                                    <div class="font-weight-boild">{{ b.title }}</div>
                                    <div class="font-weight-boild text-h3">{{ b.value }}</div>
                                </v-card>
                            </v-col>
                         </v-row>
                         <v-row>
                            <v-col cols="12" md="6" v-for="b in box2" key="b">
                                <v-card elevation="3" class="pa-4">
                                    <div class="font-weight-boild">{{ b.title }}</div>
                                    <div class="font-weight-boild text-h3">{{ b.value }}</div>
                                </v-card>
                            </v-col>
                         </v-row>
                    </v-card-text>
                </v-card>
    </v-container>
</template>

<script setup lang="ts">
import axios from 'axios'
import {api,staff} from '../API/base'
const token = process.client ? localStorage.getItem('token') : null

const result = ref([])
const box = ref([])
const box2 = ref([])

const fetch = async () => {
    try{

        const b1 = await axios.get(`${api}/dash/staff`,{headers:{Authorization: `Bearer ${token}`}})
        box.value = b1.data.box
        box2.value = b1.data.box2
        
        // const res = await axios.get(`${staff}/topic`,{headers:{Authorization: `Bearer ${token}`}})
        // result.value = res.data
    }catch(err){
        console.error('Error Fetching',err)
    }
}

onMounted(fetch)
</script>

<style scoped>
.bg-maroon{
    color: #7d0c14;
}
</style>