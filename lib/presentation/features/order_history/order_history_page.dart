import 'package:flutter/material.dart';
import 'package:flutter_appsa_22042022/common/bases/base_widget.dart';
import 'package:flutter_appsa_22042022/common/widgets/loading_widget.dart';
import 'package:flutter_appsa_22042022/data/datasources/models/order_model.dart';
import 'package:flutter_appsa_22042022/data/repositories/order_repository.dart';
import 'package:flutter_appsa_22042022/presentation/features/order_history/order_history_bloc.dart';
import 'package:flutter_appsa_22042022/presentation/features/order_history/order_history_event.dart';
import 'package:provider/provider.dart';
class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      providers: [
        Provider(create: (context) => OrderRepository()),
        ProxyProvider<OrderRepository, OrderHistoryBloc>(
            create: (context) => OrderHistoryBloc(),
            update: (context, repository, bloc) {
              bloc!.setOrderRepository(orderRepository: repository);
              return bloc;
            }
        )
      ],
      appBar: AppBar(
        title: Text("Order History"),
      ),
      child: OrderHistoryContainer(),
    );
  }
}

class OrderHistoryContainer extends StatefulWidget {
  const OrderHistoryContainer({Key? key}) : super(key: key);

  @override
  State<OrderHistoryContainer> createState() => _OrderHistoryContainerState();
}

class _OrderHistoryContainerState extends State<OrderHistoryContainer> {
  late OrderHistoryBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read();
    _bloc.eventSink.add(FetchOrderHistoryEvent());
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          child: LoadingWidget(
            bloc: _bloc,
            child: StreamBuilder<List<OrderModel>>(
              initialData: null,
              stream: _bloc.listOrder.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Data is error"),
                  );
                }
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text("Data is empty"),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) => itemList(snapshot.data?[index])
                );
              },
            ),
          ),
        )
    );
  }

  Widget itemList (OrderModel? orderModel) {
    if (orderModel == null) return Container();
    return ListTile(
      title: Text(orderModel.date_created ??= ""),
    );
  }
}

