import 'dart:convert';

import 'package:auth_api_flutter/models/user_model.dart';
import 'package:auth_api_flutter/provider/user_provider.dart';
import 'package:auth_api_flutter/shared_preferences/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status{
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut,



}

class AuthProvider extends ChangeNotifier{

  Status _LoggedInstatus = Status.NotLoggedIn;

  Status _Registeredstatus = Status.NotRegistered;

  get LoggedInStatus => _LoggedInstatus;
  get RegisteredStatus => _Registeredstatus;

  bool _userLoginstats = false;
  get userLoginstats => _userLoginstats;
  
  Map<String,String> headers = {                           
       "Content-Type": "application/json; charset=UTF-8" };  
  static var url = 'http://192.168.1.82:8000/';
  Future<Response> userLogin(String email,String password) async{
    var body = jsonEncode({'email': email, 'password': password});

    _LoggedInstatus = Status.Authenticating;
    notifyListeners();

    Response  response = await post(Uri.parse(url+'login/'),body: body,headers: headers);
    // print(response.body );
    var verify = jsonDecode(response.body);
    // print(verify);N
    if(verify['error']!=null){
      

      print('Please verify your account!');
    }
    if (response.statusCode==200){
      // print(response);
      
      var data = response.body;
      // print(data);
      // print(data);
      User user = User.fromReqBody(data);
      user.email = email;
      // print(user.id);
      // print(user.token);
      // print(user.email);
      // final _pref = await SharedPreferences.getInstance();
      UserPreferences().saveUser(user);
      
      _LoggedInstatus = Status.LoggedIn;
      notifyListeners();
    
    }
    return response;

  }
  
  
  Future<Response> userSignup(String email,String password,String confirmpassword) async{
    var body = jsonEncode({
      'email':email,
      'password':password,
      'confirm_password':confirmpassword
    });
    _Registeredstatus = Status.Registering;
    notifyListeners();
    Response response = await post(Uri.parse(url+'signup/'),headers: headers,
    body: body
    );
  if(response.statusCode==200){

    final data = response.body;
    // print(data);
    _Registeredstatus = Status.Registered;
    notifyListeners();
  }
    
    

    return response;
  
  
  
  }
  

}