import 'dart:async';

import 'package:flutter_appsa_22042022/common/bases/base_bloc.dart';
import 'package:flutter_appsa_22042022/common/bases/base_event.dart';
import 'package:flutter_appsa_22042022/data/datasources/models/user_model.dart';
import 'package:flutter_appsa_22042022/data/repositories/authentication_repository.dart';
import 'package:flutter_appsa_22042022/presentation/features/sign_in/sign_in_event.dart';

class SignInBloc extends BaseBloc {
  StreamController<UserModel> userModelController = StreamController();
  StreamController<String> message = StreamController();
  late AuthenticationRepository _authenticationRepository;

  SignInBloc({required AuthenticationRepository authenticationRepository}) {
    _authenticationRepository = authenticationRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    if (event is LoginEvent) {
      _executeLogin(event);
    }
  }

  void _executeLogin(LoginEvent event) {
    _authenticationRepository
        .login(email: event.email, password: event.password)
        .then((userResponse) {
          userModelController.sink.add(UserModel(
              email: userResponse.email ?? "",
              name: userResponse.name ?? "",
              phone: userResponse.phone ?? "",
              token: userResponse.token ?? ""));
        }).catchError((error) {
          message.sink.add(error);
        });
  }

  @override
  void dispose() {
    super.dispose();
    userModelController.close();
    message.close();
  }
}
