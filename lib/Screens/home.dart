import 'package:auth_api_flutter/models/user_model.dart';
import 'package:auth_api_flutter/provider/user_provider.dart';
import 'package:auth_api_flutter/shared_preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final  provider = Provider.of<UserProvider>(context,listen: false);
    
    print(provider.user.token);
    final  _pref =   SharedPreferences.getInstance();
    @override
    Future<String?> initState()async{
      final  _pref =  await SharedPreferences.getInstance();
      var email=_pref.getString('email');
      
      return email;
    }
    final emails = initState();
    
    return Scaffold(
      appBar: AppBar(leading:FutureBuilder(future:emails,builder:(context, snapshot) {
       return CircleAvatar(child: Text(snapshot.data.toString()));
      }, ),actions: [
        
        IconButton(icon: Icon(Icons.logout),
                onPressed:()async{
                
                 
                print(provider.user.email);
                SharedPreferences _pref = await SharedPreferences.getInstance();
                _pref.remove('email');
                _pref.remove('id');
                _pref.remove('token');
                
                Navigator.of(context).pushReplacementNamed('/login');
              }
        )
      ]),
      body:Consumer<UserProvider>(
        builder: (context, value, child) {
          print(value.user.email.toString());
          return Text(value.user.email.toString());
          
        },
        
        ),
      
    );
    
  }
}