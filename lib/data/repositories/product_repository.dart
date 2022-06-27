import 'dart:async';
import 'package:dio/dio.dart';
import '../../common/constants/api_constant.dart';
import '../datasources/remote/app_response.dart';
import '../datasources/remote/dio_request.dart';
import '../datasources/remote/product_response.dart';

class ProductRepository {
  late Dio _dio;

  ProductRepository() {
    _dio = DioRequest.instance.dio;
  }

  Future<List<ProductResponse>> fetchListProducts() {
    Completer<List<ProductResponse>> completer = Completer();
    _dio.get(ApiConstant.LIST_PRODUCTS_API).then((response){
      AppResponse<List<ProductResponse>> dataResponse = AppResponse.fromJson(response.data, ProductResponse.pareJsonModelToList);
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