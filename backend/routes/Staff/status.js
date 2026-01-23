const express = require('express')
const router = express.Router()
const db = require('../../db')
const bc = require('bcryptjs')
const {verifyToken,requireRole} = require('../../middleware/authMiddleware')

// ===================== DEMO =====================
// API สำหรับ GET ข้อมูล
// router.get('/',verifyToken,requireRole('ฝ่ายบุคลากร'),async (req,res) => {
//     try{
//         const [rows] = await db.query(``)
//         res.json(rows)
//     }catch(err){
//         console.error("Error Get",err)
//         res.status(500).json({message:'Error Get'})
//     }
// })
// ===================== DEMO =====================

// API สำหรับ GET ข้อมูล
router.get('/:id_eva',verifyToken,requireRole('ฝ่ายบุคลากร'),async (req,res) => {
    try{
        const {id_eva} = req.params
        const [rows] = await db.query(`select * from tb_eva , tb_member , tb_commit where tb_commit.id_eva='${id_eva}' and  tb_eva.id_eva=tb_commit.id_eva and tb_commit.id_member=tb_member.id_member order by tb_member.id_member desc`)
        res.json(rows)
    }catch(err){
        console.error("Error Get",err)
        res.status(500).json({message:'Error Get'})
    }
})

module.exports = router