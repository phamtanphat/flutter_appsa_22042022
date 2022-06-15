import 'package:dio/dio.dart';

class DioRequest {
  Dio? _dio;
  static BaseOptions _options = new BaseOptions(
    baseUrl: "https://freeapi.code4func.com/api/v1/",
    connectTimeout: 5000,
    receiveTimeout: 3000,
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