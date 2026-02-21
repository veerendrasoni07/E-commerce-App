# 🛍️ Flutter E-Commerce Application

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

  ## 📸 App Preview


---

## 📸 Screenshots

### 🏠 Home Page
![Screenshot_20260221_194603 jpg](https://github.com/user-attachments/assets/dc45e4ff-6b76-414e-812b-451abe409126)
![Screenshot_20260221_194416 jpg](https://github.com/user-attachments/assets/9f7ad0c3-f130-4c2e-aefe-418678040459)


---

### 🔍 Search Functionality

![Screenshot_20260221_194428 jpg](https://github.com/user-attachments/assets/3e90b25f-f30f-457f-9910-9185ad9e1369)

---

### 📦 Product Detail

![Screenshot_20260221_194359 jpg](https://github.com/user-attachments/assets/51392019-001e-4c2b-ad30-1a983ae1de4f)
![Screenshot_20260221_194404 jpg](https://github.com/user-attachments/assets/bfbc7c69-655c-47ac-92eb-e0550fb4a69c)

---

### 🛒 Cart & Checkout
![Screenshot_20260221_194525 jpg](https://github.com/user-attachments/assets/52271ce8-d85d-4d3a-928d-4960f96e6492)
![Screenshot_20260221_194530 jpg](https://github.com/user-attachments/assets/1a273a8e-cc82-4f5f-b759-a66001a11cf2)
![Screenshot_20260221_194535 jpg](https://github.com/user-attachments/assets/714898ab-354e-4cbd-8e15-02aadc6f04ba)

---

### 📜 Order History

![WhatsApp Image 2026-02-21 at 19 55 32](https://github.com/user-attachments/assets/b9d8a089-4e65-47e1-99f3-f8fe4e1058c3)
![Screenshot_20260221_194548 jpg](https://github.com/user-attachments/assets/89ea92db-78d6-4a5a-9db1-f66f05258c60)

### Account 
![Screenshot_20260221_194540 jpg](https://github.com/user-attachments/assets/4f74bd2e-a0c9-417c-bb85-1dc25cc88b0f)


### Category 
![Screenshot_20260221_194509 jpg](https://github.com/user-attachments/assets/81724f53-576b-44fd-b5fb-af701e14b721)
![Screenshot_20260221_194502 jpg](https://github.com/user-attachments/assets/e50dd0ed-8bdf-4f89-a88f-d47d042f8337)
![Screenshot_20260221_194455 jpg](https://github.com/user-attachments/assets/ee305b48-f80c-4683-96fc-bb5c7dc02280)
![Screenshot_20260221_194448 jpg](https://github.com/user-attachments/assets/82696456-3d66-4054-af15-a4b477ff44f0)



