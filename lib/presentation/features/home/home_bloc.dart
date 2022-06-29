import 'dart:async';

import 'package:flutter_appsa_22042022/common/bases/base_bloc.dart';
import 'package:flutter_appsa_22042022/common/bases/base_event.dart';
import 'package:flutter_appsa_22042022/data/datasources/models/cart_model.dart';
import 'package:flutter_appsa_22042022/data/datasources/models/product_model.dart';
import 'package:flutter_appsa_22042022/data/repositories/cart_repository.dart';
import 'package:flutter_appsa_22042022/data/repositories/product_repository.dart';
import 'package:flutter_appsa_22042022/presentation/features/home/home_event.dart';

class HomeBloc extends BaseBloc {
  StreamController<List<ProductModel>> products = StreamController();
  StreamController<CartModel> cart = StreamController.broadcast();
  StreamController<String> message = StreamController();
  late ProductRepository _productRepository;
  late CartRepository _cartRepository;

  void setRepository({required ProductRepository productRepository, required CartRepository cartRepository}) {
    _productRepository = productRepository;
    _cartRepository = cartRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    if (event is FetchProductsEvent) {
      fetchProducts();
    } else if (event is FetchCartEvent) {
      fetchCart();
    } else if (event is AddCartEvent) {
      addCart(event);
    }
  }

  void fetchCart() {
    loadingSink.add(true);
    _cartRepository
        .fetchCart()
        .then((cartData) => cart.sink.add(CartModel(
            cartData.id,
            cartData.products?.map((model) => ProductModel(
                    model.id,
                    model.name,
                    model.address,
                    model.price,
                    model.img,
                    model.quantity,
                    model.gallery))
                .toList(),
            cartData.price)))
        .catchError((e) {
      message.sink.add(e);
    }).whenComplete(() => loadingSink.add(false));
  }

  void fetchProducts() {
    loadingSink.add(true);
    _productRepository.fetchListProducts().then((listProducts) {
      products.sink.add(listProducts.map((productResponse) {
        return ProductModel(
            productResponse.id,
            productResponse.name,
            productResponse.address,
            productResponse.price,
            productResponse.img,
            productResponse.quantity,
            productResponse.gallery);
      }).toList());
    }).catchError((e) {
      message.sink.add(e);
    }).whenComplete(() => loadingSink.add(false));
  }

  void addCart(AddCartEvent event) {
    loadingSink.add(true);
    _cartRepository
        .addCart(event.idProduct)
        .then((cartData) => cart.sink.add(CartModel(
          cartData.id,
          cartData.products?.map((model) => ProductModel(
              model.id,
              model.name,
              model.address,
              model.price,
              model.img,
              model.quantity,
              model.gallery))
              .toList(),
          cartData.price)))
        .catchError((e) {
      message.sink.add(e);
    }).whenComplete(() => loadingSink.add(false));
  }

  @override
  void dispose() {
    super.dispose();
    products.close();
    message.close();
    cart.close();
  }
}
