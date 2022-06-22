import 'package:flutter/material.dart';
import 'package:flutter_appsa_22042022/data/datasources/local/cache/app_cache.dart';
import 'package:flutter_appsa_22042022/presentation/features/home/home_page.dart';
import 'package:flutter_appsa_22042022/presentation/features/sign_in/sign_in_page.dart';
import 'package:flutter_appsa_22042022/presentation/features/sign_up/sign_up_page.dart';
import 'package:flutter_appsa_22042022/presentation/features/splash/splash_page.dart';

void main() async{
  runApp(MyApp());
  await AppCache.init();
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
       "/sign-in": (context) => SignInPage(),
       "/sign-up": (context) => SignUpPage(),
       "/home": (context) => HomePage(),
       "/": (context) => SplashPage(),
      },
      initialRoute: "/",
    );
  }
}
