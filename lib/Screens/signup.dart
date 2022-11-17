import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:auth_api_flutter/Screens/login.dart';
import 'package:auth_api_flutter/provider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();

      super.dispose();
    }
    

    
      return Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(14.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: 'email'),
                      
                      
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      obscureText: false,
                      controller: passwordController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(labelText: 'password'),
                       
                      
                    ),
                    TextFormField(
                      obscureText: false,
                      controller: confirmPasswordController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(labelText: 'password'),
                      validator: (value){
                        if(passwordController.text.toString()!=confirmPasswordController.text.toString()){
                          return "password and confirm password doesn't match";
                        }
                        else{
                          return null;
                        }
                          
                        
                      },
                      
                    ),
                    SizedBox(height: 4),
                    ElevatedButton.icon(
                        onPressed: () async{
                          if(formkey.currentState!.validate()){
                          final _provider = Provider.of<AuthProvider>(context,listen: false);
                           Response  res=await  _provider.userSignup(emailController.text.toString(), passwordController.text.toString(), confirmPasswordController.text.toString());
                            // print(res.body);
                            var mssg=jsonDecode(res.body);
                            // print(mssg['email']);
                            if(res.statusCode==400){
                              //  print(mssg['email'].toString());
                               SnackBar(content: Text(mssg['email']),);
                            }
                            else if(res.statusCode==200){
                              print('Confirm your email address to login');
                              Navigator.of(context)
                                      .pushReplacementNamed('/login');
                            }
                          }
                        },
                        icon: Icon(Icons.arrow_back),
                        label: Text('Sign Up')),
                    SizedBox(height: 4),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Color.fromARGB(255, 17, 240, 102)),
                            text: 'Already have an account ? ',
                            children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/login');
                                },
                              text: 'Sign In')
                        ]))
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  
}
