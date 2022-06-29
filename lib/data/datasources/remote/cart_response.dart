import 'package:flutter_appsa_22042022/data/datasources/remote/product_response.dart';

class CartResponse {
  CartResponse({
    String? id,
    List<ProductResponse>? products,
    int? price,
  }) {
    _id = id;
    _products = products;
    _price = price;
  }

  CartResponse.fromJson(dynamic json) {
    _id = json['_id'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(ProductResponse.fromJson(v));
      });
    }
    _price = json['price'];
  }

  String? _id;
  List<ProductResponse>? _products;
  int? _price;

  String? get id => _id;

  List<ProductResponse>? get products => _products;

  int? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    map['price'] = _price;
    return map;
  }


  static CartResponse parseJson(Map<String, dynamic> json) => CartResponse.fromJson(json);
}
