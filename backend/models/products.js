const mongoose = require('mongoose');

const productSchema =new mongoose.Schema({
    productName:{
        type:String,
        required:true
    },
    productPrice:{
        type:Number,
        required:true
    },
    productQuantity:{
        type:Number,
        required:true
    },
    description:{
        type:String,
        required:true
    },
    category:{
        type:String,
        required:true
    },
    subcategory:{
        type:String,
        required:true
    },
    vendorId:{
        type:String,
        required:true
    },
    fullname:{
        type:String,
        required:true,
    },
    images:[
        {
            type:String,
            required:true
        }
    ],
    popular:{
        type:Boolean,
        default:true
    },
    recommend:{
        type:Boolean,
        default:false
    },
    totalrating:{
        type:Number,
        default:0
    },
    averagerating:{
        type:Number,
        default:0
    }
});

const Product = mongoose.model('Product',productSchema);
module.exports = Product;