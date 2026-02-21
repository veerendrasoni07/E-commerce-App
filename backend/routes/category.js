const express = require('express');
const Category = require('../models/category');
const categoryRouter = express.Router();

categoryRouter.post('/api/categories',async (req,res)=>{
    try {
        const data = req.body;
        const newCategories = new Category(data);
        const response = await newCategories.save();
        res.status(200).json(response);
    } 
    catch (error) {
        res.status(500).json({error:"Internal server error!"});
    }
});

categoryRouter.get('/api/categories',async (req,res)=>{
    try {
        const response = await Category.find();
        res.status(200).json(response);    
    } 
    catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal server error"})
    }
})

module.exports = categoryRouter;