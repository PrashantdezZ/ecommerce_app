

import 'package:auth_api_flutter/respositiory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../widgets/utils/utils.dart';

class AuthViewModel extends ChangeNotifier{

  final _myrepo = AuthRepository();

  bool _loading = false;
  bool get loading =>_loading;

  bool _signuploading = false;
  bool get signuploading => _signuploading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }
  
  setSignUpLoading(bool value){
    _signuploading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data,BuildContext context) async{
  setLoading(true);

  _myrepo.loginApi(data).then((value) {
    setLoading(false);
    Navigator.of(context).pushReplacementNamed('/home');
     if(kDebugMode){
        print(value.toString());

      }
  }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if(kDebugMode){
        print(error.toString());
      }

    });
  


}
}


