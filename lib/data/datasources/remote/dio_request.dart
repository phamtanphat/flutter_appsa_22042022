import 'package:dio/dio.dart';
import 'package:flutter_appsa_22042022/common/constants/api_constant.dart';

class DioRequest {
  Dio? _dio;
  static BaseOptions _options = new BaseOptions(
    baseUrl: ApiConstant.BASE_URL,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  static final DioRequest instance = DioRequest._internal();

  DioRequest._internal() {
    if (_dio == null){
      _dio = Dio(_options);
      _dio!.interceptors.add(LogInterceptor(requestBody: true));
      // _dio!.interceptors.add(InterceptorsWrapper(
      //   onRequest: (options, handler) async{
      //     var token = await SPref.instance.get(ConstantKey.TOKEN);
      //     if (token != null) {
      //       options.headers["Authorization"] = "Bearer " + token;
      //     }
      //     return handler.next(options);
      //   },
      //   onResponse: (e, handler) {
      //     return handler.next(e);
      //   },
      //   onError: (e, handler) {
      //     return handler.next(e);
      //   },
      // ));
    }
  }

  Dio get dio => _dio!;
}