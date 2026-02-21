const express = require('express');
const ProductReview = require('../models/rating_review');
const reviewRouter = express.Router();
const Products = require('../models/products');



reviewRouter.post('/api/product-review',async (req,res)=>{
    try {
        const data = req.body;
        // check if the user already reviewed the product or not

        const existingReview = await ProductReview.findOne({ buyerId: data.buyerId, productId: data.productId });
        if (existingReview) {
            return res.status(400).json({msg:"You have already reviewed the product"});
        }

        const newReview = new ProductReview(data);
        const response = await newReview.save();
        // find the product which are associated with rating by productId
        const product = await Products.findById(data.productId);
        if(!product){
            return res.status(400).json({msg:"Product not found"})
        }
        // if the product is found then the total rating is incremented by 1
        // Store old total
        const oldTotal = product.totalrating;
        const oldAverage = product.averagerating;

        // Update
        product.totalrating = oldTotal + 1;
        product.averagerating = ((oldAverage * oldTotal) + data.rating) / product.totalrating;
        // save the updated product back to the database
        await product.save();

        res.status(200).json(response);
    }
    catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal server error!"});
    }
})

module.exports = reviewRouter;