const express = require('express');
const Order = require('../models/order');
const { rmSync } = require('fs');
const orderRoute = express.Router();
const {auth,vendorAuth} = require('../middleware/auth');
const stripe = require('stripe')("sk_test_51RuP6k1yDEUhKcSo4mwXNksRj0sICvINayOlc6TUcNDAIkr4KihjH6J7TN22Gba3Xbo75sB5JGeELtMoJFz6XKUj006zRKw9HB");

// route for making an order
orderRoute.post('/api/order',auth,async(req,res)=>{
    try {
        const {
            fullname,
            email,
            state,
            city,
            locality,
            productName,
            productId,
            productQuantity,
            quantity,
            productPrice,
            category,
            image,
            buyerId,
            vendorId,
        } = req.body;

        const createdAt = new Date().getDate();
        
        const order = new Order({
            fullname,
            email,
            state,
            city,
            locality,
            productName,
            productId,
            productQuantity,
            quantity,
            productPrice,
            category,
            image,
            buyerId,
            vendorId,
            createdAt
        });

        const response = await order.save();
        res.status(200).json(response);

    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
})

// fetching all order of specific user
orderRoute.get('/api/order/:buyerId',async (req,res)=>{
    try {
        const buyerId = req.params.buyerId;
        const order = await Order.find({buyerId});
        if(order.length==0){
            return res.status(404).json({msg:"Order is not available for this user"})
        }
        return res.status(200).json(order);

    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
})


// payment route 
orderRoute.post('/api/payment',async(req,res)=>{
    try {
        const {amount,currency} = req.body;
        
        const paymentIntent = await stripe.paymentIntents.create(
            {
                amount,
                currency
            }
        )
        
        res.status(200).json(paymentIntent);

    } catch (error) {
     console.log(error);
     res.status(500).json({error:"Internal Server Error"});   
    }
});




// delete route for deleting the orders

orderRoute.delete('/api/order/delete/:id',auth,async (req,res)=>{
    try {
        const orderId = req.params.id; 
        const response = await Order.findByIdAndDelete(orderId);
        if(!response){
            res.status(404).json({msg:"Invalid order"})
        }
        else{
            console.log("Order is deleted")
            res.status(200).json(response);
        }
        
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
});


// get order by vendor id

orderRoute.get('/api/orders/vendors/:vendorId',auth,vendorAuth,async (req,res)=>{
    try {
        const vendorId = req.params.vendorId;
        const order = await Order.find({vendorId});
        if(order.length==0){
            return res.status(404).json({msg:"Order is not available for this user"})
        }
        return res.status(200).json(order);

    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
});

orderRoute.patch('/api/orders/vendors/delivered/:id',async(req,res)=>{
    try {
        const {id} = req.params;
        const updatedOrder = await Order.findByIdAndUpdate(
            id,
            {delivered:true,},
            {new:true}
        );
        if(!updatedOrder){
            return res.status(404).json({msg:"Order not found!"})
        }
        res.status(200).json(updatedOrder);

    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal server error"})
    }
})

orderRoute.patch('/api/orders/vendors/processing/:id',async(req,res)=>{
    try {
        const {id} = req.params;
        const updatedOrder = await Order.findByIdAndUpdate(
            id,
            {processing:false,delivered:false},
            {new:true}
        );
        if(!updatedOrder){
            return res.status(404).json({msg:"Order not found!"})
        }
        res.status(200).json(updatedOrder);

    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal server error"})
    }
})


// fetching order for admin panel user
orderRoute.get('/api/orders/',async(req,res)=>{
    try {
        const order = await Order.find();
        res.status(200).json(order);
    } catch (error) {
        console.log(error);
        res.status(500).json({error:e.message});
    }
});

module.exports = orderRoute;