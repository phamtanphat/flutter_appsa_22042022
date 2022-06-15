import 'package:flutter/material.dart';
import 'package:flutter_appsa_22042022/presentations/features/sign_in/sign_in_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "QuickSan",
        primarySwatch: Colors.blue,
      ),
      routes: {
       "/sign-in": (context) => SignInPage()
      },
      initialRoute: "/sign-in",
    );
  }
}
