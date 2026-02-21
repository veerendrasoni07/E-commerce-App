import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/views/screens/authentication/register_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pinput/pinput.dart';

import '../../../controller/auth_controller.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  bool isPasswordVisible = false;

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
                  "Login",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),


                const SizedBox(height: 30),

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
                ),
                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>ChangePasswordFlow()));
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      authService.signInUser(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context,
                          ref: ref
                      );
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
                      "Login",
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
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
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
class ChangePasswordFlow extends StatefulWidget {
  const ChangePasswordFlow({super.key});

  @override
  State<ChangePasswordFlow> createState() => _ChangePasswordFlowState();
}

class _ChangePasswordFlowState extends State<ChangePasswordFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(), // email
    GlobalKey<FormState>(), // otp
    GlobalKey<FormState>(), // password
  ];
  TextEditingController passController1 = TextEditingController();
  TextEditingController passController2 = TextEditingController();
  TextEditingController controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;
  bool isEnable = false;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();


  }


  void nextPage(){
    if(_currentPage < 2){
      setState(() => _currentPage++);
      _pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    }
  }
  void previousPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
    pinController.dispose();
    focusNode.dispose();
    formKey.currentState!.dispose();
    emailController.dispose();
    passController1.dispose();
    passController2.dispose();
    controller.dispose();
  }



  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
        appBar: AppBar(
            leading:IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 15,
                  color: Colors.black),
              onPressed: () => {
                _currentPage > 0 ? previousPage() : Navigator.pop(context)
              },
            )

        ),
        body: SafeArea(
            child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Form(
                    key: _formKeys[0],
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Please Enter Your Registered Email!",style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: emailController,
                            cursorColor: Colors.white,
                            validator: (value)=> value == null || value.isEmpty
                                ? "Please enter registered email"
                                : null,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                                hintText: "Enter registered email",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                prefixIcon: Icon(Icons.email),
                                prefixIconColor: Colors.blue,
                                filled: true,
                                fillColor: Colors.grey.shade900,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  gapPadding: 10,
                                )
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: ()async{
                              if(_formKeys[0].currentState!.validate()){
                                showDialog(context: context,barrierDismissible: false, builder: (context){
                                  return Center(child: CircularProgressIndicator(color: Colors.white,),);
                                });
                                await AuthService().getOTP(emailController.text, context);
                                Navigator.pop(context);
                                nextPage();
                              }
                            },
                            child: Text("Next",style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),)
                        )
                      ],
                    ),
                  ) ,
                  Form(
                    key: _formKeys[1],
                    child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("OTP Is Sent To Your Registered Email!",style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                          Directionality(
                            // Specify direction if desired
                            textDirection: TextDirection.ltr,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Pinput(
                                controller: pinController,
                                focusNode: focusNode,
                                length: 6,
                                defaultPinTheme: defaultPinTheme,
                                separatorBuilder: (index) => const SizedBox(width: 8),
                                hapticFeedbackType: HapticFeedbackType.lightImpact,
                                onCompleted: (pin) async{
                                  showDialog(context: context,barrierDismissible: false, builder: (context){
                                    return Center(child: CircularProgressIndicator(color: Colors.white,),);
                                  });
                                  await AuthService().verifyOTP(emailController.text, int.parse(pin) );
                                  Navigator.pop(context);
                                  nextPage();
                                },
                                onChanged: (value) {
                                  debugPrint('onChanged: $value');
                                },
                                cursor: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 9),
                                      width: 22,
                                      height: 1,
                                      color: focusedBorderColor,
                                    ),
                                  ],
                                ),
                                focusedPinTheme: defaultPinTheme.copyWith(
                                  decoration: defaultPinTheme.decoration!.copyWith(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: focusedBorderColor),
                                  ),
                                ),
                                submittedPinTheme: defaultPinTheme.copyWith(
                                  decoration: defaultPinTheme.decoration!.copyWith(
                                    color: fillColor,
                                    borderRadius: BorderRadius.circular(19),
                                    border: Border.all(color: focusedBorderColor),
                                  ),
                                ),
                                errorPinTheme: defaultPinTheme.copyBorderWith(
                                  border: Border.all(color: Colors.redAccent),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Didn't receive OTP?",style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),),
                              SizedBox(width: 5,),
                              OtpTimerButton(
                                  onPressed: ()async{
                                    showDialog(context: context,barrierDismissible: false, builder: (context){
                                      return Center(child: CircularProgressIndicator(color: Colors.white,),);
                                    });
                                    await AuthService().getOTP(emailController.text, context);
                                    Navigator.pop(context);
                                  },
                                  backgroundColor: Colors.green,
                                  text: Text("Resend OTP",style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  )),
                                  loadingIndicator: CircularProgressIndicator(color: Colors.grey,),
                                  duration: 60
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ]
                    ),
                  ),
                  SingleChildScrollView(
                    child: Form(
                      key: _formKeys[2],
                      child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text("Please Enter Your New Password!",style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                controller: passController1,
                                cursorColor: Colors.white,
                                validator: (value) =>
                                value == null || value.isEmpty
                                    ? "Please confirm your password"
                                    : null,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                    hintText: "Enter new password",
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    prefixIcon: Icon(Icons.lock),
                                    prefixIconColor: Colors.blue,
                                    filled: true,
                                    fillColor: Colors.grey.shade900,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      gapPadding: 10,
                                    )
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                controller: passController2,
                                validator: (value) =>
                                value == null || value.isEmpty
                                    ? "Please enter new password"
                                    : null,
                                cursorColor: Colors.white,
                                obscureText: isEnable ? true : false ,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                    hintText: "Confirm new password",
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    prefixIcon: Icon(Icons.lock),
                                    prefixIconColor: Colors.blue,
                                    filled: true,
                                    fillColor: Colors.grey.shade900,
                                    suffixIcon: IconButton(onPressed: (){
                                      setState(() {
                                        isEnable = !isEnable;
                                      });
                                    }, icon: Icon(isEnable==true ? Icons.visibility_off : Icons.remove_red_eye)),
                                    suffixIconColor: Colors.blue,

                                    suffixStyle: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      gapPadding: 10,
                                    )
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: EdgeInsets.all(12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                                shadowColor: Colors.black,
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                                minimumSize: Size(200, 50),
                                maximumSize: Size(200, 50),
                                fixedSize: Size(200, 50),
                                side: BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                surfaceTintColor: Colors.blue,
                                foregroundColor: Colors.blue,
                                splashFactory: InkSplash.splashFactory,
                              ),
                              onPressed: ()async{
                                bool isValid = _formKeys[2].currentState!.validate();

                                if (isValid) {
                                  if (passController1.text != passController2.text) {
                                    //showSnackBar(context, "Password does not match", "Please confirm your password", ContentType.failure);
                                  } else {
                                    showDialog(context: context,barrierDismissible: false, builder: (context){
                                      return Center(child: CircularProgressIndicator(color: Colors.white,),);
                                    });
                                    await AuthService().resetPassword(
                                      email: emailController.text,
                                      password: passController1.text,
                                      context: context,
                                    );
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                    }
                                  }
                                }
                              },
                              child: Text("Confirm",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),),
                            )
                          ]
                      ),
                    ),
                  )
                ]
            )
        )
    );
  }
}