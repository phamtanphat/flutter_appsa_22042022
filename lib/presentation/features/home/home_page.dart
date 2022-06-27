import 'package:flutter/material.dart';
import 'package:flutter_appsa_22042022/data/repositories/product_repository.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ProductRepository repository = ProductRepository();
    repository
        .fetchListProducts()
        .then((value) => print(value))
        .catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
