import 'package:flutter_appsa_22042022/data/datasources/models/product_model.dart';

class OrderModel {
  late String? id;
  late List<ProductModel>? products;
  late int? price;
  late bool? status;
  late String? date_created;

  OrderModel(String? id, List<ProductModel>? products, int? price, bool? status, String? date_created) {
    this.id = id ??= "";
    this.price = price ??= -1;
    this.products = products ??= [];
    this.status = status ??= false;
    this.date_created = date_created ??= "";
  }
}
