# 🛍️ FreshCart – Flutter E-Commerce Application

A modern, scalable, and production-ready E-Commerce mobile application built with **Flutter**.

This project was developed as part of an evaluation assignment to demonstrate:

- UI design capability  
- State management understanding  
- Backend integration  
- Full-stack architectural thinking  

---

## 🚀 Overview

This application implements a clean and responsive home page featuring:

- Promotional banner slider  
- Horizontally scrollable categories  
- Product grid layout  
- Search functionality  
- Product detail page  
- Related products section  
- Add to Cart system  
- Order history tracking  
- Google Sign-In authentication  
- Stripe payment integration  
- AWS-hosted backend integration  

The objective was not only to complete the UI requirement but to demonstrate full-stack capability and scalable architecture.

---

## 📱 Features

### 🏠 Home Page
- Custom designed AppBar  
- Promotional slider with smooth page indicator  
- Responsive product grid  
- Clean and modern UI design  

### 🔍 Search
- Real-time product filtering  
- Efficient list updates using reactive state management  

### 🛒 Cart & Checkout
- Add to Cart functionality  
- Swipe-to-delete using slidable widgets  
- Stripe payment integration  

### 📦 Order History
- Tracks user orders  
- Displays previously purchased items  
- Maintains session using local storage  

### 🔗 Related Products
- Dynamically displayed related products on detail page  
- Encourages product discovery  

### 🔐 Authentication
- Email Based Authentication Using JWT 
- OTP verification flow with timer-based validation  

### ☁️ Backend Integration
- REST API integration using `http`  
- Backend deployed on AWS  
- Secure token-based authentication  
- Real product data fetching  

---

## 🧱 Tech Stack

### 🎯 Frontend
- **Flutter (Dart)**

### ☁️ Backend
- **REST APIs deployed on AWS**

### 🔄 State Management
- **Riverpod**
- **Provider**

---

## 📦 Packages Used

| Package | Purpose |
|----------|----------|
| flutter_riverpod | Scalable state management |
| provider | Lightweight state handling |
| http | Backend API communication |
| shared_preferences | Local token/session storage |
| google_sign_in | Authentication |
| flutter_stripe | Payment integration |
| google_fonts | Modern typography |
| smooth_page_indicator | Slider indicators |
| awesome_snackbar_content | Enhanced snackbars |
| flutter_slidable | Swipe actions |
| custom_rating_bar | Product ratings UI |
| otp_timer_button | OTP verification timer |
| pinput | PIN/OTP input UI |

---

## 📂 Project Structure

├── models/
├── providers/
├── services/
├── screens/
├── widgets/

### Folder Responsibilities

- **models/** – Data models  
- **providers/** – State management logic  
- **services/** – API communication layer  
- **screens/** – UI screens  
- **widgets/** – Reusable UI components  

This modular structure ensures scalability, readability, and long-term maintainability.

---

## 🎨 Design Approach

- Clean and minimal UI  
- Consistent spacing system  
- Responsive grid using dynamic column count  
- Proper hierarchy: Image → Title → Rating → Price → Call-To-Action  
- Touch-friendly interactive elements  
- Modern typography with Google Fonts  

The objective was to maintain production-level polish rather than a basic academic layout.

---

## ⚙️ Architecture Decisions

- Used Riverpod for scalable reactive state handling  
- Separated API layer from UI for improved maintainability  
- Implemented modular folder structure  
- Integrated backend deployment to extend beyond mock data  
- Ensured UI works consistently across Android and iOS  

---

## 🧠 Challenges Faced

- Designing a custom AppBar layout with balanced spacing and usability  
- Managing nested scrolling (slider + categories + grid)  
- Handling asynchronous API calls with state synchronization  
- Securely integrating Stripe payment flow  
- Maintaining consistent responsiveness across screen sizes  

---

## 🔮 Future Improvements

- Advanced filtering and sorting  
- Pagination for large datasets  
- Dark mode support  
- Real-time inventory updates  
- Push notifications  
- Caching optimization  
