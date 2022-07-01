import 'dart:async';

import 'package:flutter_appsa_22042022/common/bases/base_bloc.dart';
import 'package:flutter_appsa_22042022/common/bases/base_event.dart';
import 'package:flutter_appsa_22042022/data/datasources/models/order_model.dart';
import 'package:flutter_appsa_22042022/data/datasources/models/product_model.dart';
import 'package:flutter_appsa_22042022/data/repositories/order_repository.dart';
import 'package:flutter_appsa_22042022/presentation/features/order_history/order_history_event.dart';

class OrderHistoryBloc extends BaseBloc {
  StreamController<List<OrderModel>> listOrder = StreamController();
  StreamController<String> message = StreamController();
  late OrderRepository _repository;

  void setOrderRepository({required OrderRepository orderRepository}) {
    _repository = orderRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    if (event is FetchOrderHistoryEvent) {
      fetchOrderHistory(event);
    }
  }

  void fetchOrderHistory(FetchOrderHistoryEvent event) {
    loadingSink.add(true);
    _repository.fetchOrderHistory().then((orderListsData) {
      listOrder.sink.add(orderListsData.map((order) {
        return OrderModel(
            order.id,
            order.products
                ?.map((productResponse) => ProductModel(
                productResponse.id,
                productResponse.name,
                productResponse.address,
                productResponse.price,
                productResponse.img,
                productResponse.quantity,
                productResponse.gallery))
                .toList(),
            order.price,
            order.status,
            order.date_created);
      }).toList());
    }).catchError((e) {
      message.sink.add(e);
    }).whenComplete(() => loadingSink.add(false));
  }

  @override
  void dispose() {
    super.dispose();
    listOrder.close();
    message.close();
  }
}
