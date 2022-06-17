import 'package:flutter_appsa_22042022/common/bases/base_event.dart';

abstract class SignUpEvent extends BaseEvent {}

class SignUpExecuteEvent extends SignUpEvent {
  late String name, email, phone, password, address;

  SignUpExecuteEvent({
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
    required this.address,
  });

  @override
  List<Object?> get props => [];
}

class SignUpSuccessEvent extends SignUpEvent {
  @override
  List<Object?> get props => [];
}
