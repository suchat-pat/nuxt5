<template>
    <v-container fluid class="fill-height">
        <v-row justify="center" align="center">
            <v-col cols="12" md="8" lg="5">
                <v-card elevation="10" rounded="lg" color="#7d0c14">
                    <p class="text-center font-weight-bold text-white">ระบบประเมินบุคลากรวิทยาลัยเทคนิคน่าน</p>
                    <p class="text-center font-weight-bold text-white text-h5">NTC EVALUATION SYTEM</p>
                    <v-container class="bg-white">
                        <p class="text-center font-weight-bold">เข้าสู่ระบบ</p>
                        <v-alert type="error" v-if="error" variant="tonal">{{ error }}</v-alert>
                        <v-form @submit.prevent="Login">
                            <v-text-field v-model="username" label="ชื่อผู้ใช้" prepend-inner-icon="mdi-account"></v-text-field>
                            <v-text-field v-model="password" label="รหัสผ่าน" type="password" prepend-inner-icon="mdi-lock"></v-text-field>
                            <v-select v-model="role" label="ประเภทสมาชิก" :items="g" prepend-inner-icon="mdi-account-group"></v-select>
                            <v-btn color="#7d0c14" block type="submit">เข้าสู่ระบบ</v-btn>
                        </v-form>
                        <center><nuxt-link to="/regis" class="text-blue">สมัครสมาชิก</nuxt-link></center>
                    </v-container>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">
definePageMeta({
    layout:false
})

import auth from '../API/auth'

const error = ref('')
const username = ref('')
const password = ref('')
const role = ref('')
const g = ['ฝ่ายบุคลากร','กรรมการประเมิน','ผู้รับการประเมินผล']

const Login = async () => {
    try{
       const res = await auth.login({
            username:username.value,
            password:password.value,
            role:role.value,
       })
       console.log("API Response :",res.data)
       localStorage.setItem('token',res.data.token)
       const useRole = res.data.role
       if(useRole === 'ฝ่ายบุคลากร') useRouter().push('/Staff')
       if(useRole === 'กรรมการประเมิน') useRouter().push('/Committee')
       if(useRole === 'ผู้รับการประเมิน') useRouter().push('/Evaluatee')
    }catch(err){
        console.error('Error Login',err)
        error.value = error.response?.data?.message || 'เข้าสู่ระบบไม่สำเร็จ'
    }
}

</script>

<style scoped>

</style>