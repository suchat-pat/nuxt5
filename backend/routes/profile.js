const express = require('express')
const router = express.Router()
const db = require('../db')
const {verifyToken} = require('../middleware/authMiddleware')

router.get('/',verifyToken,async (req,res) => {
    try{
        const id_member = req.user.id_member
        const [rows] = await db.query(`select first_name,last_name,email,username,role from tb_member where id_member=?`,[id_member])
        console.log('rows:',rows)
        res.json(rows[0])
    }catch(err){
        console.error('Error Get User',err)
        res.status(500).json({message:'Error Get User'})
    }
})

module.exports = router