import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/model/user.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/utils/utils.dart';
import 'package:frontend/views/screens/authentication/register_screen.dart';
import 'package:frontend/views/screens/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../global_variables.dart' show uri;
import '../views/screens/authentication/login_screen.dart';

class AuthService {
  Future<void> signUpUser({
    required BuildContext context,
    required WidgetRef ref,
    required String email,
    required String password,
    required String fullname,
  }) async {
    try {
      User user = User(
        id: '',
        fullname: fullname,
        password: password,
        email: email,
        state: '',
        city: '',
        locality: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInUser({
    required BuildContext context,
    required WidgetRef ref,
    required String email,
    required String password,
  }) async {
    try {
      final navigator = Navigator.of(context);

      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {

          SharedPreferences preferences = await SharedPreferences.getInstance();

          String token = await jsonDecode(res.body)['token'];

          await preferences.setString('auth-token', token);

          final userJson = jsonEncode(jsonDecode(res.body)['user']);

          ref.read(userProvider.notifier).setUser(userJson);

          await preferences.setString('user', userJson);

          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
                (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // update user location
  Future<void> updateUserLocation({
    required context,
    required WidgetRef ref,
    required String id,
    required  String state,
    required String city,
    required String locality
  })async{
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('auth-token');
      http.Response response = await http.put(
          Uri.parse('$uri/api/update-address'),
          headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8',
            'x-auth-token':token!
          },
          body: jsonEncode({
            'state':state,
            'city':city,
            'locality':locality
          })
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: ()async{
            final _userProvider = ref.read(userProvider.notifier);
            SharedPreferences preferences = await SharedPreferences.getInstance();
            await preferences.setString('user', response.body);
            _userProvider.setUser(response.body);
            showSnackBar(context, 'Location updated successfully!');
          }
      );

    }
    catch(e){
      showSnackBar(context, "Failed to update the shipping address");
    }
  }

  // sign out
  void signOut(BuildContext context, WidgetRef ref) async {
    final navigator = Navigator.of(context);
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Are you sure! You want to logout?",style: GoogleFonts.martel(fontSize: 18,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                          )
                      ),
                        onPressed: ()=>Navigator.pop(context),
                        child: Text("Cancel")
                    ),
                    SizedBox(width: 8,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        )
                      ),
                        onPressed: ()async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.remove('auth-token');

                          // Clear user state
                          ref.read(userProvider.notifier).signOut();

                          navigator.pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                                (route) => false,
                          );
                        },
                        child: Text("Logout")
                    )

                  ],
                )
              ],
            ),
          );
        }
    );

  }

  Future<bool> getOTP(String email,BuildContext context)async {
    try{
      http.Response response = await  http.post(
        Uri.parse('$uri/api/get-otp'),
        body: jsonEncode({
          "email":email
        }),
        headers: <String,String>{
          'Content-Type':'application/json; charset=UTF-8'
        },
      );
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        //showSnackBar(context, "OTP SENT" ,"OTP is sent to your email",ContentType.warning);
        return data['success'];
      }
      else{
        //showSnackBar(context, "OTP NOT SENT" ,jsonDecode(response.body)['msg'],ContentType.failure);
        Navigator.pop(context);
        throw Exception(response.body);
      }
    }catch(e){
      print(e);
      throw Exception(e);
    }
  }

  Future<bool> verifyOTP(String email,int otp)async {
    try{
      http.Response response = await  http.post(
        Uri.parse('$uri/api/get-otp'),
        body: jsonEncode({
          "email":email,
          "otp":otp
        }),
        headers: <String,String>{
          'Content-Type':'application/json; charset=UTF-8'
        },
      );
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        return data['success'];
      }
      else{
        print(response.body);
        throw Exception('Failed to get OTP');
      }
    }catch(e){
      print(e);
      throw Exception(e);
    }
  }

  Future<void> resetPassword({required String email ,required String password,required BuildContext context})async{
    try{
      http.Response response = await http.post(
          Uri.parse('$uri/api/reset-password'),
          body: jsonEncode({
            "password":password,
            "email":email
          }),
          headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8'
          }
      );
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        //showSnackBar(context, 'Success', data['msg'],ContentType.success);
      }
      else{
        print(response.body);
        throw Exception('Failed to reset password');
      }
    }catch(e){
      print(e.toString());
      throw Exception(e.toString());
    }
  }


}




