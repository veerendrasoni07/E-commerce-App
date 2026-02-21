const express = require('express');
const vendorRoute = express.Router();
const Vendor = require('../models/vendor');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const User = require('../models/user');

vendorRoute.post('/api/vendor/signup',async (req,res)=>{
    try {
        const {email,password,fullname} = req.body;
        const existingUserEmail = await User.findOne({email});
        if(existingUserEmail){
            return res.status(404).json({msg:"User with same email already exist"});
        }
        const existingVendor = await Vendor.findOne({email});
        if(existingVendor){
            return res.status(401).json({msg:"Vendor with same email already exist!"})
        }
         const hashedPassword = await bcrypt.hash(password, 8);
        
            let user = new Vendor({
              email,
              password: hashedPassword,
              fullname,
            });
            user = await user.save();
            res.json(user);
    } catch (error) {
        console.log(error);
        res.status(200).json({error:"Internal Server Error"});
    }
})


vendorRoute.post('/api/vendor/signin',async (req,res)=>{
    try {
        const {email,password} = req.body;
        const vendor = await Vendor.findOne({email});
        if(!vendor){
            return res.status(401).json({msg:"Invalid email!"})
        }
        const isMatch = await bcrypt.compare(password,vendor.password);
        if(!isMatch){
            return res.status(401).json({msg:"Invalid password!"})
        }
        const token = await jwt.sign({id:vendor._id},"passwordKey");
        const withoutPassword = vendor._doc;
        delete withoutPassword.password;
        res.status(200).json({token,vendor:withoutPassword})
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"})
    }
});

module.exports = vendorRoute;