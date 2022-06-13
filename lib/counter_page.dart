import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appsa_22042022/counter_bloc.dart';
import 'package:flutter_appsa_22042022/counter_event.dart';

class CounterPage extends StatefulWidget {

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {

  late CounterBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = CounterBloc();
    super.didChangeDependencies();
  }

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
                _bloc.eventController.sink.add(IncreaseEvent(value: 1));
              }, child: Text("+")),
              StreamBuilder<int>(
                  initialData: 0,
                  stream: _bloc.countController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData){
                      return Text("Count: ${snapshot.data}");
                    } else if (snapshot.hasError) {
                      return Text("Error");
                    }
                    return Text("Count:");
                  }
              ),
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

