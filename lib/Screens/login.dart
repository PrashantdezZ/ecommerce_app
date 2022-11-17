import 'package:auth_api_flutter/provider/auth_provider.dart';
import 'package:auth_api_flutter/provider/new_auth_provider.dart';
import 'package:auth_api_flutter/shared_preferences/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../provider/user_provider.dart';
import '../widgets/utils/round_button.dart';
import '../widgets/utils/utils.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final  email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  

  
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<AuthProvider>(context);
    final provider  = Provider.of<AuthViewModel>(context);
    final bool isLoading = false;
    print('user');
     return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: email,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'email'),
                    
                  ),
                      
                  SizedBox(height:4),
                  TextFormField(
                    obscureText :true,
                    controller: password,
                    cursorColor: Colors.white,
                    validator: (value) {
                      if (value!=null){
                        if(password.text.length<=6){
                          return 'password is smaller than 6 characters';
                        }
                        return null;

                    }
                    
                    },
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(labelText: 'password'),
                  ),
                  SizedBox(height:4),
                  // ElevatedButton.icon(onPressed:() 
                  
                  
                  // async{
                  //   if(formKey.currentState!.validate()){
                  //      Map data = {
                  //       'email':email.text.toString(),
                  //       'password':  password.text.toString()
                  //      };
                  //       final req = await provider.loginApi(data, context);
                        
                        
                  //     }
                  //   else{
                  //     SnackBar(content: ErrorWidget(formKey.currentState!.toString()),);
                      
                  //   }
                    
                    
                    
                  // }, icon: Icon(Icons.login), label: Text('Login')),
                  RoundButton(
              title: 'Login',
              loading: provider.loading,
              onPress: (){
                if(email.text.isEmpty){

                  Utils.flushBarErrorMessage('Please enter email', context);
                }else if(password.text.isEmpty){
                  Utils.flushBarErrorMessage('Please enter password', context);

                }else if(password.text.length < 6){
                  Utils.flushBarErrorMessage('Please enter 6 digit password', context);

                }else {


                  Map data = {
                    'email' : email.text.toString(),
                    'password' : password.text.toString(),
                  };

                  // Map data = {
                  //   'email' : 'eve.holt@reqres.in',
                  //   'password' : 'cityslicka',
                  // };

                  provider.loginApi(data , context);
                  print('api hit');
                }
              },
            ),
                  SizedBox(height:4),
                  
                  GestureDetector(
                    child: const Text(
                      'Forgot Password?',
                      style:TextStyle(
                        decoration : TextDecoration.underline,
                        color:Colors.green,
                        fontSize: 20,
                      )
                    ),
                  //   onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  //     builder: ((context) => ResetPassword())) ,
                  // ),
                   ),
                  SizedBox(height: 15,),
                  IconButton(onPressed: () {},
                   icon: Icon(Icons.add)),
                  RichText(
                    text:  TextSpan(
                      style:TextStyle(color: Color.fromARGB(255, 2, 2, 2)),
                      text: 'No Account? ',
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                          ..onTap =  (){
                            Navigator.pushReplacementNamed(context, '/signup');
                          },
                          text: 'Sign up'
                
                        )
                
                      ]
                
                    )
                  )
                    
                ],
              ),
            ),
          ),
          
        ),
      ),
    );

    
  }
}