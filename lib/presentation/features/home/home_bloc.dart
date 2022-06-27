import 'dart:async';

import 'package:flutter_appsa_22042022/common/bases/base_bloc.dart';
import 'package:flutter_appsa_22042022/common/bases/base_event.dart';
import 'package:flutter_appsa_22042022/data/datasources/models/product_model.dart';
import 'package:flutter_appsa_22042022/data/repositories/product_repository.dart';
import 'package:flutter_appsa_22042022/presentation/features/home/home_event.dart';

class HomeBloc extends BaseBloc {
  StreamController<List<ProductModel>> products = StreamController();
  StreamController<String> message = StreamController();
  late ProductRepository _productRepository;

  void setProductRepository({required ProductRepository productRepository}) {
    _productRepository = productRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    if (event is FetchProductsEvent) {
      fetchProducts();
    }
  }

  void fetchProducts() {
    loadingSink.add(true);
    _productRepository
        .fetchListProducts()
        .then((listProducts) {
          products.sink.add(listProducts.map((productResponse) {
            return ProductModel(
                productResponse.id,
                productResponse.name,
                productResponse.address,
                productResponse.price,
                productResponse.img,
                productResponse.quantity,
                productResponse.gallery);
          }).toList());})
        .catchError((e) { message.sink.add(e); })
        .whenComplete(() => loadingSink.add(false));
  }

  @override
  void dispose() {
    super.dispose();
    products.close();
    message.close();
  }
}