import 'package:frontend/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends StateNotifier<User?>{

  UserProvider():super(
      User(
        id: '',
        fullname: '',
        state: '',
        city: '',
        locality: '',
        email: '',
        password: '',
      )
  );


  User? get user => state;

  void setUser(String userJson){
    state = User.fromJson(userJson);
  }

  void signOut(){
    state = null;
  }


}

// global provider

final userProvider = StateNotifierProvider<UserProvider,User?>((ref){
  return UserProvider();
});
