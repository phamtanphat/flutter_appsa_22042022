import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter Bloc"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){

              }, child: Text("+")),
              TextWidget(),
              ElevatedButton(onPressed: (){

              }, child: Text("-")),
            ],
          ),
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text("Count : 0");
  }
}

