const Otp = require('../models/otp');
const express = require('express');
const otpRouter = express.Router();
const crypto = require('crypto');
const nodemailer = require('nodemailer');
const jwt = require('jsonwebtoken');
const User = require('../models/user');

otpRouter.post('/api/send-otp',async(req,res)=>{
    try{
        const {email} = req.body;
        const userExist = await User.findOne({email});
        if(!userExist){
            return res.status(401).json({msg:"User with this email doesn't exist"});
        }
        // generate otp using crypto
        const otp = crypto.randomInt(10000,99999);
        
        // save the otp in db instantly
        await Otp.create({
            email,
            otp:otp,
            expiresAt:Date.now() + 60*1000*5
        });

        // create transport 
        const transport = nodemailer.createTransport(
            {
                service:'gmail',
                auth:{user:'veerendrasoni0555@gmail.com',pass:"zcyb nsgj fnoa gywg"}
            }
        );


        await transport.sendMail(
            {
                from:"Ur Store",
                to:email,
                subject:"Your Authentication Otp",
                text:`Your Otp is ${otp} . It will expire in 5 minutes`
            }
        )

        res.status(200).json({success:true});

    }
    catch(e){
        console.log(e);
        res.status(500).json({e:"Internal Server Error"});
    }
});



// verify otp

otpRouter.post('/api/verify-otp',async(req,res)=>{
    try{
        const {email,otp} = req.body;
        const userExist = await User.findOne({email});
        if(!userExist) return res.status(401).json({msg:"User doesn't exist"});
        const otpExist = await Otp.findOne({email}).sort({createdAt:-1});
        if(!otpExist){
            return res.status(403).json({success:false,msg:"Otp doesn't exist"});
        }
        if(otp !== otpExist.otp){
            return res.status(403).json({success:false,msg:"Otp is invalid"});
        }
        if(otpExist.expiresAt < Date.now()){
            return res.status(403).json({success:false,msg:"Otp Expires"});
        }

        // delete all the otp of that user 
        await Otp.deleteMany({
            email
        });
        const token = jwt.sign({id:userExist._id},"passwordKey");
        res.status(200).json({token,user:userExist._doc});
    }catch(e){
        console.log(e);
        res.status(500).json({e:"Internal Server Error"});
    }
});

module.exports = otpRouter;