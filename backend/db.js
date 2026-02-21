const mongodb = require('mongodb');
const  mongoose  = require('mongoose');
const dotenv = require('dotenv');
dotenv.config();
// password = QHQuwgsggVb2atnF,
// username = veerendrasoni0555

// const MONGOURL = "mongodb+srv://veerendrasoni05:3plT0RazyKpaTGqR@cluster0.wha5thr.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

 mongoose.connect(process.env.MONGOURL);
 
 const db = mongoose.connection;

 db.on('connected',()=>{
    console.log("Mongodb connected")
 })
 db.on('disconnected',()=>{
    console.log("Mongodb disconnected")
 })
 db.on('error',(error)=>{
    console.log("Mongodb Connection Error:",error);
 })

module.exports = db;

