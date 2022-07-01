import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_appsa_22042022/data/datasources/remote/order_response.dart';
import '../../common/constants/api_constant.dart';
import '../datasources/remote/app_response.dart';
import '../datasources/remote/dio_request.dart';

class OrderRepository {
  late Dio _dio;

  OrderRepository() {
    _dio = DioRequest.instance.dio;
  }

  Future<List<OrderResponse>> fetchOrderHistory() {
    Completer<List<OrderResponse>> completer = Completer();
    _dio.post(ApiConstant.ORDER_HISTORY_API).then((response){
      AppResponse<List<OrderResponse>> dataResponse = AppResponse.fromJson(response.data, OrderResponse.parseJson);
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