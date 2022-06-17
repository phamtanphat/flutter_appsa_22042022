import 'package:flutter/material.dart';
import 'package:flutter_appsa_22042022/common/bases/base_widget.dart';
import 'package:flutter_appsa_22042022/common/widgets/loading_widget.dart';
import 'package:flutter_appsa_22042022/common/widgets/progress_listener_widget.dart';
import 'package:flutter_appsa_22042022/data/repositories/authentication_repository.dart';
import 'package:flutter_appsa_22042022/presentation/features/sign_in/sign_in_bloc.dart';
import 'package:flutter_appsa_22042022/presentation/features/sign_in/sign_in_event.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      providers: [
        Provider(create: (context) => AuthenticationRepository()),
        ProxyProvider<AuthenticationRepository,SignInBloc>(
          create: (context) => SignInBloc(),
          update: (context, repository, bloc) {
            bloc!.setAuthenticationRepository(authenticationRepository: repository);
            return bloc;
          }
        )
      ],
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      child: SignInContainer(),
    );
  }
}

class SignInContainer extends StatefulWidget {
  const SignInContainer({Key? key}) : super(key: key);

  @override
  State<SignInContainer> createState() => _SignInContainerState();
}

class _SignInContainerState extends State<SignInContainer> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  var isPassVisible = true;
  late SignInBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          color: Colors.white,
          constraints: BoxConstraints.expand(),
          child: LoadingWidget(
            bloc: _bloc,
            child: ProgressListenerWidget<SignInBloc>(
              callback: (event){
                print(event.runtimeType);
              },
              child: Column(
                children: [
                  Expanded(
                      flex: 2, child: Image.asset("assets/images/ic_hello_food.png")),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPhoneTextField(),
                          _buildPasswordTextField(),
                          _buildButtonSignIn(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: _buildTextSignUp())
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget _buildTextSignUp() {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account!"),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/sign-up");
              },
              child: Text("Sign Up",
                  style: TextStyle(
                      color: Colors.red, decoration: TextDecoration.underline)),
            )
          ],
        ));
  }

  Widget _buildPhoneTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          hintText: "Email",
          labelStyle: TextStyle(color: Colors.blue),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          prefixIcon: Icon(Icons.email, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _passController,
        obscureText: isPassVisible,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          hintText: "PassWord",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          labelStyle: TextStyle(color: Colors.blue),
          prefixIcon: Icon(Icons.lock, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildButtonSignIn() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: ElevatedButtonTheme(
            data: ElevatedButtonThemeData(
                style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue[500];
                } else if (states.contains(MaterialState.disabled)) {
                  return Colors.grey;
                }
                return Colors.blueAccent;
              }),
              elevation: MaterialStateProperty.all(5),
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 5, horizontal: 100)),
            )),
            child: ElevatedButton(
              child: Text("Login",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              onPressed: () {
                String email = _emailController.text.toString();
                String password = _passController.text.toString();

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Input empty")));
                  return;
                }

                _bloc.eventSink.add(LoginEvent(email: email, password: password));
              },
            )));
  }
}
