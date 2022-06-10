import 'dart:async';

import 'package:flutter_appsa_22042022/counter_event.dart';

class CounterBloc {
  StreamController<CounterEvent> eventController = StreamController();
  StreamController<int> countController = StreamController();

  CounterBloc() {
    eventController.stream.listen((event) {
      if (event.runtimeType == IncreaseEvent) {
        print("${event.runtimeType}");
      }
    });
  }

  void dispose () {
    eventController.close();
    countController.close();
  }
}