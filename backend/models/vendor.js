const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const vendorSchema = new mongoose.Schema({
    fullname:{
        type:String,
        required:true,
        trim:true
    },
    state:{
        type:String,
        default:""
    },
    city:{
        type:String,
        default:""
    },
    locality:{
        type:String,
        default:""
    },
    role:{
        type:String,
        default:"vendor"
    },
    email:{
        type:String,
        required:true,
        trim:true,
        unique:true,
        validate:{
            validator:(value)=>{
                const result = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
                return result.test(value);
            },
            message:"Please enter a valid email address!"
        }
    },
    password:{
        type:String,
        required:true,
    }
});


const Vendor = mongoose.model('Vendor',vendorSchema);
module.exports = Vendor;