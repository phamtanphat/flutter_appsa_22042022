import 'package:flutter/material.dart';
import 'package:flutter_appsa_22042022/common/bases/base_widget.dart';
import 'package:flutter_appsa_22042022/common/constants/api_constant.dart';
import 'package:flutter_appsa_22042022/common/widgets/loading_widget.dart';
import 'package:flutter_appsa_22042022/data/datasources/models/product_model.dart';
import 'package:flutter_appsa_22042022/data/repositories/product_repository.dart';
import 'package:flutter_appsa_22042022/presentation/features/home/home_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      providers: [
        Provider(create: (context) => ProductRepository()),
        ProxyProvider<ProductRepository,HomeBloc>(
            create: (context) => HomeBloc(),
            update: (context, repository, bloc) {
              bloc!.setProductRepository(productRepository: repository);
              return bloc;
            }
        )
      ],
      appBar: AppBar(
        title: Text("Product"),
      ),
      child: HomeContainer(),
    );
  }
}

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  late HomeBloc homeBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeBloc = context.read();
    homeBloc.fetchProducts();
  }
  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      bloc: homeBloc,
      child: StreamBuilder<List<ProductModel>>(
          initialData: [],
          stream: homeBloc.products.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Data is error");
            } else if (snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return _buildItemFood(snapshot.data?[index]);
                  });
            } else {
              return Container();
            }
          }
      ),
    );
  }

  Widget _buildItemFood(ProductModel? product) {
    if (product == null) return Container();
    return Container(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(ApiConstant.BASE_URL + product.img,
                    width: 150, height: 120, fit: BoxFit.fill),
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
                        child: Text(product.name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "Giá : " +
                              NumberFormat("#,###", "en_US")
                                  .format(product.price) +
                              " đ",
                          style: TextStyle(fontSize: 12)),
                      ElevatedButton(
                        onPressed: () {

                        },
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Color.fromARGB(200, 240, 102, 61);
                              } else {
                                return Color.fromARGB(230, 240, 102, 61);
                              }
                            }),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))))),
                        child:
                        Text("Add To Cart", style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

