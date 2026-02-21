import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/utils/utils.dart';
import 'package:frontend/views/screens/authentication/login_screen.dart';
import 'package:frontend/views/screens/authentication/register_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pinput/pinput.dart';

import '../../../controller/auth_controller.dart';


class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final AuthService authService = AuthService();

  bool isPasswordVisible = false;
  bool isConfirmPassVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF9F45F8),
              Color(0xFF71D5FF)
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(20),
                //   child: Image.asset(
                //     'assets/images/login_image.jpg', // Replace with your AI-themed login image
                //     height: 200,
                //   ),
                // ),
                const SizedBox(height: 20),
                Text(
                  "Sign Up",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                //fullname
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: emailController ,
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Full Name",

                      hintStyle: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                      prefixIcon: Icon(Icons.person_4_rounded,color: Colors.black,),
                      contentPadding: EdgeInsets.all(18),
                    ),
                  ),
                ),const SizedBox(height: 20),
                // Email TextField
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: emailController ,
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",

                      hintStyle: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                      prefixIcon: Icon(Icons.email_outlined,color: Colors.black,),
                      contentPadding: EdgeInsets.all(18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password TextField
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: isPasswordVisible ? false : true,
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      hintStyle: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                      prefixIcon: Icon(Icons.lock_outline,color: Colors.black,),
                      suffixIcon: InkWell(
                        onTap:(){
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        } ,
                        child: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off_outlined,color: Colors.black,),
                      ),
                      contentPadding: EdgeInsets.all(18),
                    ),
                  ),
                ),const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: confirmPasswordController,
                    obscureText: isConfirmPassVisible ? false : true,
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Confirm Password",
                      hintStyle: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                      prefixIcon: Icon(Icons.lock_outline,color: Colors.black,),
                      suffixIcon: InkWell(
                        onTap:(){
                          setState(() {
                            isConfirmPassVisible = !isConfirmPassVisible;
                          });
                        } ,
                        child: Icon(isConfirmPassVisible ? Icons.visibility : Icons.visibility_off_outlined,color: Colors.black,),
                      ),
                      contentPadding: EdgeInsets.all(18),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     onPressed: () {},
                //     child: const Text(
                //       "Forgot Password?",
                //       style: TextStyle(color: Colors.white),
                //     ),
                //   ),
                // ),
                //
                // const SizedBox(height: 16),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: ()async {
                      if(passwordController.text.isEmpty || confirmPasswordController.text.isEmpty || emailController.text.isEmpty || fullnameController.text.isEmpty){
                        showSnackBar(context, "Please fill all the fields");
                      }
                      if(passwordController.text != confirmPasswordController.text) {
                        showSnackBar(context, "Passwords don't match");
                      }
                      showDialog(context: context, builder: (_){
                        return Center(child: CircularProgressIndicator());
                      });
                      await authService.signInUser(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context,
                          ref: ref
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFFB266FF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Signup",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Divider
                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.white70)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "OR",
                        style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.white70)),
                  ],
                ),

                const SizedBox(height: 20),

                // Google Login
                // SizedBox(
                //   width: double.infinity,
                //   child: OutlinedButton.icon(
                //     label: Text(
                //       "Login via OTP",
                //       style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),
                //     ),
                //     style: OutlinedButton.styleFrom(
                //       padding: const EdgeInsets.symmetric(vertical: 14),
                //       side: const BorderSide(color: Colors.white),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20),
                //       ),
                //     ),
                //     onPressed: () {
                //       Navigator.push(context, MaterialPageRoute(builder: (_)=>ChangePasswordFlow()));
                //     },
                //   ),
                // ),

                const SizedBox(height: 15),

                // Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}