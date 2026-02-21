const express = require('express');
const Subcategory = require('../models/subcategory');
const subcategoryRouter = express.Router();

subcategoryRouter.post('/api/subcategory',async (req,res)=>{
    try {
        const data = req.body;
        const newSubcategory = new Subcategory(data);
        const response = await newSubcategory.save();
        res.status(200).json(response);
    }
    catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server error!"});
    }
});

subcategoryRouter.get('/api/category/:categoryName/subcategory',async(req,res)=>{
    try {
        const {categoryName} = req.params;
        const response = await Subcategory.find({categoryName:categoryName});
        if(!response){
            return res.status(404).json({msg:"Category not found!"});
        }
        res.status(200).json(response);
    }
    catch (error) {
        res.status(500).json({error:"Internal server error!"});
    }
});

subcategoryRouter.get('/api/subcategory',async(req,res)=>{
    try {
        const response = await Subcategory.find();
        res.status(200).json(response);
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
});


module.exports = subcategoryRouter;