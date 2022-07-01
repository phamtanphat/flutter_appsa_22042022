import 'package:flutter/material.dart';
import 'package:flutter_appsa_22042022/common/bases/base_widget.dart';
import 'package:flutter_appsa_22042022/common/constants/api_constant.dart';
import 'package:flutter_appsa_22042022/common/widgets/loading_widget.dart';
import 'package:flutter_appsa_22042022/data/datasources/models/cart_model.dart';
import 'package:flutter_appsa_22042022/data/datasources/models/product_model.dart';
import 'package:flutter_appsa_22042022/data/repositories/cart_repository.dart';
import 'package:flutter_appsa_22042022/presentation/features/cart/cart_bloc.dart';
import 'package:flutter_appsa_22042022/presentation/features/cart/cart_event.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      providers: [
        Provider(create: (context) => CartRepository()),
        Provider(create: (context) => CartBloc()),
        ProxyProvider<CartRepository,CartBloc>(
            create: (context) => CartBloc(),
            update: (context, cartRepo, bloc) {
              bloc!.setRepository(cartRepository: cartRepo);
              return bloc;
            })
      ],
      appBar: AppBar(
        title: Text("Cart"),
      ),
      child: CartContainer(),
    );
  }
}

class CartContainer extends StatefulWidget {
  const CartContainer({Key? key}) : super(key: key);

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  CartModel? _cartModel;
  late CartBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read();
    _bloc.eventSink.add(FetchCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context, _cartModel);
        return true;
      },
      child: LoadingWidget(
        bloc: _bloc,
        child: Center(
          child: StreamBuilder<CartModel>(
            stream: _bloc.cart.stream,
            initialData: null,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error.toString()}"),
                );
              }

              if (snapshot.hasData) {
                _cartModel = snapshot.data;
                if (snapshot.data == null || snapshot.data!.products!.isEmpty) {
                  return Text("Data empty");
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data?.products?.length,
                          itemBuilder: (lstContext, index) => _buildItem(snapshot.data?.products?[index])),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                            "Tổng tiền : " +
                                NumberFormat("#,###", "en_US")
                                    .format(_cartModel?.price) +
                                " đ",
                            style: TextStyle(fontSize: 25, color: Colors.white))),
                    Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_cartModel != null) {
                              String idCart = _cartModel!.id ??= "";
                              _bloc.eventSink.add(CartConform(idCart: idCart));
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.deepOrange)),
                          child: Text("Confirm",
                              style: TextStyle(color: Colors.white, fontSize: 25)),
                        )),
                  ],
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildItem(ProductModel? product) {
    return Container(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                      ApiConstant.BASE_URL + (product?.img).toString(),
                      width: 150,
                      height: 120,
                      fit: BoxFit.fill),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text((product?.name).toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "Giá : " +
                              NumberFormat("#,###", "en_US")
                                  .format(product?.price) +
                              " đ",
                          style: TextStyle(fontSize: 12)),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (product != null && _cartModel != null ) {
                                String cartId = _cartModel!.id ??= "";
                                if (cartId.isNotEmpty) {
                                  _bloc.eventSink.add(UpdateCartEvent(idCart: cartId, idProduct: product.id, quantity: product.quantity - 1));
                                }
                              }
                            },
                            child: Text("-"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text((product?.quantity).toString(),
                                style: TextStyle(fontSize: 16)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (product != null && _cartModel != null ) {
                                String cartId = _cartModel!.id ??= "";
                                if (cartId.isNotEmpty) {
                                  _bloc.eventSink.add(UpdateCartEvent(idCart: cartId, idProduct: product.id, quantity: product.quantity + 1));
                                }
                              }
                            },
                            child: Text("+"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
