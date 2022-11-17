import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  

  @override
  void initState(){
    Timer(Duration(seconds: 1),()=>getUser());
    super.initState();
  }
    getUser()async{
    

    SharedPreferences preferences = await SharedPreferences.getInstance();
    // print(preferences.getString('email'));
    var email = preferences.getString('email');
    if(email!=null){
      Navigator.pushReplacementNamed(context, '/home');
    }
    else{
      Navigator.pushReplacementNamed(context, '/login');
    }
    
  } 

  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: Colors.green,
      
    );

    
  }
}