const express = require('express');
const app = express();
const db = require('./db');
const PORT = process.env.PORT || 3000;
const authRouter = require('./routes/auth_route');
const bannerRouter = require('./routes/banner');
const categoryRouter = require('./routes/category');
const subcategoryRouter = require('./routes/subcategory');
const productRouter = require('./routes/product');
const ProductReview = require('./routes/productReview');
const vendorRoute = require('./routes/vendor');
const orderRoute = require('./routes/order');
const otpRouter = require('./routes/otp');
const cors = require('cors');


app.use(express.json());
app.use(cors()); 
app.use(authRouter);
app.use(bannerRouter);
app.use(categoryRouter);
app.use(subcategoryRouter);
app.use(productRouter);
app.use(ProductReview);
app.use(vendorRoute);
app.use(orderRoute);
app.use(otpRouter);

app.listen(PORT,'0.0.0.0',()=>{
    console.log("Server is connected Successfully");
})