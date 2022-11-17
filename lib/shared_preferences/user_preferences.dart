



import 'package:auth_api_flutter/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void updateSharedpreferences(int id,String token,String email,String password,bool email_confirmed) async{

// SharedPreferences _pref = await SharedPreferences.getInstance();

// _pref.setInt('id', id);
// _pref.setString('email',email);


// _pref.setString('token', token);

// }
class UserPreferences{

  Future<bool> saveUser(User user)async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();

    _pref.setString('email', user.email!);
    _pref.setInt('id', user.id!);
    _pref.setString('token', user.token!);
    // _pref.setBool('is_verified', user.emailVerified!);

    return _pref.commit();

    

  }

  void removeUser() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();

    _pref.remove('email');
    _pref.remove('id');
    _pref.remove('token');
    
  }
  Future<User> getUser() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();

    int? id = _pref.getInt('id');
    String? email = _pref.getString('email');
    String? token = _pref.getString('token');

    return User(
      email: email,
      id: id,
      token: token
    );

  }
  Future<String?> getToken(args) async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();

    final token = _pref.getString('token');
    return token;
  }
}