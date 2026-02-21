const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const Vendor = require('../models/vendor');
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const {auth} = require("../middleware/auth");
const Otp = require('../models/otp');
const { createTransport } = require("nodemailer");
const { randomInt } = require("crypto");

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { fullname, email, password } = req.body;
    const existingVendorEmail = await Vendor.findOne({email});
    if(existingVendorEmail){
      return res.status(404).json({msg:"Vendor with same email already exist"});
    }
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      fullname,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Sign In

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    console.log(user._doc);
    console.log("User signed in successfully");
    res.json({ token,"user":user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


authRouter.post('/api/get-otp',async(req,res)=>{
    try {
        const {email} = req.body;

        if(!email) return res.status(400).json({msg:"email is missing"});

        

        const user = await User.findOne({email});

        if(!user) return res.status(400).json({msg:"User with this email doesn't exist"});
        const otp = randomInt(100000,999999);
        await Otp.create({
            email,
            otp,
            expiresAt: Date.now() + 5 *60*1000
        });

        const transport = createTransport(
            {
                // service:'gmail',
                // auth:{
                //     user: process.env.EMAIL,
                //     pass: process.env.EMAIL_PASS
                // },
                service : 'gmail',
                port: 587,
                auth: {
                    user: process.env.EMAIL,
                    pass: process.env.EMAIL_PASS
                }
            }
        );


        await transport.sendMail({
            from:"E-Commerce App",
            to:email,
            subject: 'Verify Your Email - E Commerce App',
            text:`Otp is ${otp}, It will expire within 5 minutes`,
            html:  `
                <div style="background-color: #f6f6f6; padding: 20px; font-family: Arial, sans-serif;">
                    <div style="max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 30px; border-radius: 10px; box-shadow: 0 3px 10px rgba(0,0,0,0.1);">
                        <div style="text-align: center; margin-bottom: 30px;">
                            <h1 style="color: #333; margin: 0;">Password Reset Request</h1>
                            <p style="color: #666; margin-top: 10px;">E-Commerce App</p>
                        </div>
                        <div style="color: #555; font-size: 16px; line-height: 1.5;">
                            <p>Hello,</p>
                            <p>We received a request to reset your password for your E-Commerce App account. Your security is important to us, and we want to ensure that only you have access to your account.</p>
                            <div style="background-color: #f8f8f8; padding: 20px; text-align: center; margin: 25px 0; border-radius: 8px; border: 1px dashed #ccc;">
                                <p style="margin: 0 0 10px; color: #666;">Your Password Reset Code:</p>
                                <h2 style="color: #2c3e50; letter-spacing: 8px; margin: 0; font-size: 32px;">${otp}</h2>
                            </div>
                            <div style="background-color: #fff8dc; padding: 15px; border-radius: 5px; margin: 20px 0;">
                                <p style="margin: 0; color: #666;">⚠️ Important Security Notes:</p>
                                <ul style="margin: 10px 0 0; padding-left: 20px; color: #666;">
                                    <li>This code will expire in 5 minutes</li>
                                    <li>Never share this code with anyone</li>
                                    <li>Our team will never ask for this code</li>
                                </ul>
                            </div>
                            <p>If you didn't request this password reset, please ignore this email or contact our support team immediately at <a href="mailto:support@ecommerceapp.com" style="color: #007bff; text-decoration: none;">support@ecommerceapp.com</a></p>
                            <div style="margin-top: 40px; padding-top: 20px; border-top: 1px solid #eee;">
                                <p style="color: #888; font-size: 14px; text-align: center; margin: 0;">Stay connected with the E-Commerce App</p>
                                <div style="text-align: center; margin-top: 15px;">
                                    <a href="#" style="color: #007bff; text-decoration: none; margin: 0 10px;">Website</a>
                                    <a href="#" style="color: #007bff; text-decoration: none; margin: 0 10px;">Twitter</a>
                                    <a href="#" style="color: #007bff; text-decoration: none; margin: 0 10px;">GitHub</a>
                                </div>
                                <p style="color: #888; font-size: 12px; text-align: center; margin-top: 20px;">© 2024 E-Commerce App. All rights reserved.</p>
                            </div>
                        </div>
                    </div>
                </div>
            `
        });

        res.status(200).json({success:true,msg:'Otp is send'});

    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
});

// verify the otp

authRouter.post('/api/verify-otp',async(req,res)=>{
    try {
        const {email,otp} = req.body;
        if(!email || !otp){
            return res.status(400).json({msg:"email or otp is missing"});
        }
        const user = await User.findOne({email});
        if(!user) return res.status(401).json({msg:"User doesn't exist"});
        const otpExist = await Otp.findOne({otp}).sort({createdAt:-1});
        if(!otpExist) return res.status(400).json({success:false,msg:"Otp Not Found"});
        if(otp !== otpExist.otp) return res.status(400).json({success:false,msg:"Invalid Otp"});
        if(Date.now()>otpExist.expiresAt) return res.status(401).json({success:false,msg:"Otp expired"});
        await Otp.deleteMany({email});
        res.status(200).json({success:true});
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});   
    }
});

authRouter.post('/api/reset-password',async(req,res)=>{
    try {
        const {email,password} = req.body;
        if(!email || !password){
            return res.status(400).json({msg:"email or password is missing"});
        }
        const user = await User.findOne({email});
        if(!user) return res.status(401).json({msg:"User doesn't exist"});
        const hashedPassword = await bcryptjs.hash(password,10);
        user.password = hashedPassword;
        await user.save();
        console.log("password reset successfully");
        res.status(200).json({msg:"password reset successfully"});
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
});

authRouter.put('/api/update-address',auth,async(req,res)=>{
  try {
    const {state,city,locality}=req.body;
    const user = await User.findByIdAndUpdate(req.user,{
      locality,
      city,
      state
    },{new:true});
    res.status(200).json(user);
  } catch (error) {
    console.log(error);
    res.status(500).json({error:"Internal Server Error"});
  }
})


// route for checking is token is valid or not
authRouter.post('/api/isTokenValid',async(req,res)=>{
  try {
    const token = req.header('x-auth-token');
    if(!token) return res.status(400).json(false);
    const verified = jwt.verify(token,"passwordKey");
    if(!verified) return res.status(400).json({msg:"Token is not verified"});
    const user = await User.findById(verified.id);
    if(!user) return res.status(400).json(false);
    return res.status(200).json(true);
  } catch (error) {
    console.log(error);
    res.status(500).json({error:error.message});
  }
});

// if token is valid then only we have to give user data to the app otherwise no.
//TODO : route will be here

authRouter.get('/',auth,async(req,res)=>{
  try {
    const user = await User.findById(req.user);
    const token = req.token;
    res.status(200).json({token,...user._doc});
  } catch (error) {
    console.log(error);
    res.status(500).json({msg:"Internal Server Error"});
  }
}) 


// delete user account or vendor account
authRouter.delete('/api/delete-account',auth,async(req,res)=>{
    try {
        const userId = req.user;
        const user = await User.findById(userId);
        const vendor = await Vendor.findById(userId);
        if (!user && !vendor) {
            return res.status(404).json({ msg: "User or Vendor not found!" });
        }
        if(user){
          await User.findByIdAndDelete(userId);
        } else {
          await Vendor.findByIdAndDelete(userId);
        }
        res.status(200).json({ msg: "Account deleted successfully!" });
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
});




// fetching all the user/buyer for admin panel

authRouter.get('/api/users',async(req,res)=>{
  try {
    const user = await User.find().select('-password'); // Exclude password field
    return res.status(200).json(user);
  } catch (error) {
    res.status(500).json({error:error.message});
  }
})


module.exports = authRouter;