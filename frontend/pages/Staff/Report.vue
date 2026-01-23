<template>
    <v-container fluid class="py-10">
                <v-card>
                    <v-sheet class="pa-4" color="">
                        <h1 class="text-h5 text-center font-weight-bold bg-maroon" >รายงานผล</h1>
                    </v-sheet>
                    <v-card-text>
                       รายชื่อผู้รับการประเมิน
                        <v-table>
                            <thead>
                                <tr>
                                    <th class="text-center border">ลำดับ</th>
                                    <th class="text-center border">รายงาน</th>
                                    <th class="text-center border">รายละเอียด</th>
                                </tr>
                            </thead>
                            <tbody>
                               <tr>
                                <td class="text-center border">1</td>
                                <td class="text-center border">ผู้รับการประเมินทั้งหมด</td>
                                <td class="text-center border">
                                    <v-btn color="warning" size="small"><nuxt-link to="/Staff/reEva">รายละเอียด</nuxt-link></v-btn>
                                </td>
                               </tr>
                               <tr>
                                <td class="text-center border">2</td>
                                <td class="text-center border">กรรมการประเมินทั้งหมด</td>
                                <td class="text-center border">
                                    <v-btn color="warning" size="small"><nuxt-link to="/Staff/reCommit">รายละเอียด</nuxt-link></v-btn>
                                </td>
                               </tr>
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

</script>

<style scoped>
.bg-maroon{
    color: #7d0c14;
}
</style>