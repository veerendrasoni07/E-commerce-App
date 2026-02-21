const express = require('express');
const productRouter = express.Router();
const Product = require('../models/products');
const {auth,vendorAuth} = require('../middleware/auth');



productRouter.post('/api/add-product',auth,vendorAuth,async (req,res)=>{
    try {
        const data = req.body;
        const newProduct = new Product(data);
        const response = await newProduct.save();
        res.status(200).json(response);
    } 
    catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal server error!"});
    }
});


productRouter.get('/api/popular-product',async (req,res)=>{
    try {
        const response = await Product.find({popular:true});
        if(!response || response.length==0){
            return res.status(404).json({msg:"Product not found!"});
        }
        res.status(200).json(response);
    }
    catch (error) {
        res.status(500).json({error:"Internal server error!"});
    }
});

productRouter.get('/api/recommend-product',async(req,res)=>{
    try {
        const response = await Product.find({recommend:true});
        if(!response || response.length==0){
            return res.status(404).json({msg:"Product not found"});
        }
        res.status(200).json(response);    
    }
    catch (error) {
        res.status(500).json({error:"Internal server error!"});
    }
});

// new route for retreving product by category 

productRouter.get('/api/product-by-category/:categoryName',async (req,res)=>{
    try {
        const {categoryName} = req.params;
        const response = await Product.find({ category:categoryName });
        if(!response || response.length==0){
            return res.status(404).json({msg:"Product not found"});
        }
        res.status(200).json(response);
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal server error"});
    }
});


// new routes for retreiving product by subcategory
productRouter.get('/api/product-by-subcategory/:subcategoryName',async(req,res)=>{
    try {
        const {subcategoryName} = req.params;
        const response = await Product.find({subcategory:subcategoryName});
        if(!response || response.length==0){
            return res.status(404).json({msg:"No Product Found"});
        }
        res.status(200).json(response);
    } catch (error) {
        console.log(error);
        res.status(500).json({error:e.message});
    }
});


// making route to display similar subcategory products 

productRouter.get('/api/similar-product-by-subcategory/:productId',async(req,res)=>{
    try {
        const productId = req.params.productId;
        // first find the product to get its subcategory
        const product = await Product.findById(productId);
        if(!product){
            return res.status(401).json({msg:"Product not found"});
        }
        //find similar product on basis of subcategory of the retreived product
        const relatedProduct = await Product.find({
            subcategory : product.subcategory,
            _id : {$ne:productId} // "$ne" -> means not equal , it means we fetching all the product excluding current product.
        });

        if(!relatedProduct || relatedProduct.length == 0){
            return res.status(404).json({msg:"No Product Found"});
        }
        return res.status(200).json(relatedProduct);

    } catch (error) {
        console.log(error);
        return res.status(500).json({error:error.message});
    }
});

// making route for retreving the top 10 highest top rated product.

productRouter.get('/api/top-rated-products',async(req,res)=>{
    try {
        // fetch all the product and sort them by averagerating in decending order (highest rating to lowest rating).
        // sort product by averagerating , where -1 indicating decending order 
        const topRatedProducts = await Product.find({}).sort({averagerating : -1}).limit(10);
        // check the topRatedProducts are available or not.
        if(!topRatedProducts || topRatedProducts.length == 0){
            return res.status(404).json({msg:"No top-rated products are available"});
        }
        return res.status(200).json(topRatedProducts);
    } catch (error) {
        console.log(error);
        res.status(500).json({error:error.message});
    }
})

// making this route for seaching product by name or description.
productRouter.get('/api/search-products',async(req,res)=>{
    try {
        // extract the query from the request query string
        const {query} = req.query;
        // validate that a query parameter is provided or not.
        // if query is missing then return 404 error
        if(!query){
            return res.sendStatus(400).json({msg:"Query parameter required"});
        }

        // search for the product collection for documents where etheir "ProductName" or "Description"
        // contains the specified query string

        const searchedProducts = await Product.find({
            $or:[
                // Regex will match any productName or description containing the query string.
                // for example : if the user search for "apple" then regex will check
                // if "apple" is part of any productName , like Product Name "Green Apple Pie",
                // or "Fresh Apple" , all would match because they contains "apple" word within in. 
                {productName:{$regex:query,$options:'i'}},
                {description:{$regex:query,$options:'i'}},
            ]
        });

        res.status(200).json(searchedProducts);

    } catch (error) {
        console.log(error);
        res.status(500).json({error:error.message});
    }
})


// create an api so that vendor who is the owner of the product can update the details of the product.

productRouter.put('/api/update-product/:productId',auth,vendorAuth,async(req,res)=>{
    try{
        const {productId} = req.params;
        const product = await Product.findById(productId);
        if(!product){
            return res.status(403).json({msg:"Product not found"});
        }
        if(product.vendorId !== req.user.id){ // we are checking that the vendor who is updating details is the owner of the product or not.
            return res.status(403).json({msg:"Authorization is failed"});
        }

        // destructuring req.body to exclude vendorId.
        const {vendorId,...updatedData} = req.body; 
        
        // now update the product details with the field which is in the updatedData.
        const updatedProduct = await Product.findByIdAndUpdate(
            productId,
            {$set:updatedData}, // the "$set" is the operator which is provided by mongoDb, It's task is only to update or set the 
                                // provided fields without tempering other fields.
            {new:true}
        );

        res.status(200).json(updatedProduct);


    }catch(e){
        console.log(e);
        res.status(500).json({e:"Internal Server Error"});
    }
})




module.exports = productRouter;