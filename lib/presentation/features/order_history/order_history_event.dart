import 'package:flutter_appsa_22042022/common/bases/base_event.dart';

abstract class OrderHistoryEvent extends BaseEvent {}

class FetchOrderHistoryEvent extends OrderHistoryEvent {

  @override
  List<Object?> get props => [];
}
