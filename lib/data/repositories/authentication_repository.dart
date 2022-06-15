import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_appsa_22042022/common/constants/api_constant.dart';
import 'package:flutter_appsa_22042022/data/datasources/remote/app_response.dart';
import 'package:flutter_appsa_22042022/data/datasources/remote/dio_request.dart';
import 'package:flutter_appsa_22042022/data/datasources/remote/user_response.dart';

class AuthenticationRepository {
  late Dio _dio;

  AuthenticationRepository() {
    _dio = DioRequest.instance.dio;
  }

  Future<UserResponse> login({String email = "", String password = ""}) {
    Completer<UserResponse> completer = Completer();
    _dio.post(ApiConstant.LOGIN_API, data: {
      "email": email,
      "password": password
    }).then((response){
      AppResponse<UserResponse> dataResponse = AppResponse.fromJson(response.data, UserResponse.parseJson);
      completer.complete(dataResponse.data);
    }).catchError((error) {
      if (error is DioError) {
        completer.completeError((error).response?.data["message"]);
      } else {
        completer.completeError(error);
      }
    });
    return completer.future;
  }
}