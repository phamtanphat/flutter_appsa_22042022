import 'dart:async';

import 'package:flutter_appsa_22042022/common/bases/base_bloc.dart';
import 'package:flutter_appsa_22042022/common/bases/base_event.dart';
import 'package:flutter_appsa_22042022/data/datasources/models/user_model.dart';

class SignInBloc extends BaseBloc {
  StreamController<UserModel> userModelController = StreamController();

  @override
  void dispatch(BaseEvent event) {

  }

  @override
  void dispose() {
    super.dispose();
    userModelController.close();
  }
}