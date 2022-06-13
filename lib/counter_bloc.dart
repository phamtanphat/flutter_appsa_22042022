import 'dart:async';

import 'package:flutter_appsa_22042022/counter_event.dart';

class CounterBloc {
  StreamController<CounterEvent> eventController = StreamController();
  StreamController<int> countController = StreamController();
  int total = 0;

  CounterBloc() {
    countController.sink.add(total);
    eventController.stream.listen((event) {
      if (event.runtimeType == IncreaseEvent) {
        increase(event);
      }
    });
  }

  void increase(CounterEvent event) {
    int input = (event as IncreaseEvent).value;
    total += input;
    countController.sink.add(total);
  }

  void dispose () {
    eventController.close();
    countController.close();
  }
}