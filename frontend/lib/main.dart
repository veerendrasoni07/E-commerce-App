
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/views/screens/authentication/register_screen.dart';
import 'package:frontend/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    Future<void> checkTokenAndVendor() async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('auth-token');
      String? userJson = preferences.getString('user');
      if(token!=null && userJson!=null){
        ref.read(userProvider.notifier).setUser(userJson);
      }
      else{
        ref.read(userProvider.notifier).signOut();
      }
    }
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: checkTokenAndVendor(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const CircularProgressIndicator();
            }
            final user = ref.watch(userProvider);
            return user!=null ? MainScreen() : SignupScreen();
          }
      ),
    );
  }
}


