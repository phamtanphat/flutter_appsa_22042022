import 'package:flutter_appsa_22042022/data/datasources/remote/product_response.dart';

class OrderResponse {
  OrderResponse({
    String? id,
    List<ProductResponse>? products,
    int? price,
    bool? status,
    String? date_created,
  }) {
    _id = id;
    _products = products;
    _price = price;
    _status = status;
    _date_created = date_created;
  }

  OrderResponse.fromJson(dynamic json) {
    _id = json['_id'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(ProductResponse.fromJson(v));
      });
    } else {
      _products = [];
    }
    _price = json['price'];
    _status = json['status'];
    _date_created = json['date_created'];
  }

  String? _id;
  List<ProductResponse>? _products;
  int? _price;
  bool? _status;
  String? _date_created;

  String? get id => _id;

  List<ProductResponse>? get products => _products;

  int? get price => _price;

  bool? get status => _status;

  String? get date_created => _date_created;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    map['price'] = _price;
    map['status'] = _status;
    map['date_created'] = _date_created;
    return map;
  }


  static List<OrderResponse> parseJson(List list) {
    List<OrderResponse> data = list.map((json) => OrderResponse.fromJson(json)).toList();
    return data;
  }
}
