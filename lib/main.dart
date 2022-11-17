import 'package:auth_api_flutter/Screens/login.dart';
import 'package:auth_api_flutter/Screens/signup.dart';
import 'package:auth_api_flutter/provider/auth_provider.dart';
import 'package:auth_api_flutter/provider/new_auth_provider.dart';
import 'package:auth_api_flutter/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/home.dart';
import 'Screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences preferences = await SharedPreferences.getInstance();
  // preferences.getString('token');
  // print(preferences.getString('email'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>AuthProvider()),
        ChangeNotifierProvider(create: (_)=>AuthViewModel()),
        ChangeNotifierProvider(
          create: (context) =>UserProvider() ,
        )
      ],
      child:  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splashscreen',
      home: Home(),
      routes: {
        '/splashscreen':(context) => SplashScreen(),
        '/home':(context) => Home(),
        '/login':(context)=>Login(),
        '/signup':(context )=>SignUp()
      },
    ),
    );
  }
}

