import 'package:flutter_appsa_22042022/common/bases/base_event.dart';

abstract class SignInEvent extends BaseEvent {

}

class LoginEvent extends SignInEvent {
  late String email, password;

  LoginEvent({required this.email,required this.password});

  @override
  List<Object?> get props => [];

}