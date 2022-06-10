abstract class CounterEvent {

}

class IncreaseEvent extends CounterEvent {

  int value;

  IncreaseEvent({required this.value});
}