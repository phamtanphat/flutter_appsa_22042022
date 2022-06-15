import 'package:flutter/material.dart';
import 'package:flutter_appsa_22042022/commons/base/base_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
        providers: [],
        appBar: AppBar(
          title: Text("Sign In"),
        ),
        child: SignInContainer() ,
    );
  }
}

class SignInContainer extends StatefulWidget {
  const SignInContainer({Key? key}) : super(key: key);

  @override
  State<SignInContainer> createState() => _SignInContainerState();
}

class _SignInContainerState extends State<SignInContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

