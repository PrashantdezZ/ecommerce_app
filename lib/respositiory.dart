

import 'package:auth_api_flutter/network/BaseApiservice.dart';
import 'package:auth_api_flutter/network/NetworkApiservice.dart';
import 'package:auth_api_flutter/res/appurl.dart';

class AuthRepository {

  BaseApiService _apiService = NetworkApiService();

  Future<dynamic> loginApi(dynamic data )async{

    try{

      dynamic response = await _apiService.getPostApiResponse(AppUrl.loginEndPint, data);
      return response ;

    }catch(e){
      throw e ;
    }
  }
  Future<dynamic> SignupApi(dynamic data) async{

    try{
      dynamic response = await _apiService.getPostApiResponse(AppUrl.registerApiEndPoint, data);
    }catch(e){
      throw e;
    }
  }

}