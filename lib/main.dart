import 'package:creditbank/constants.dart';
import 'package:creditbank/screens/home/home.dart';
import 'package:creditbank/screens/login/login_screen.dart';
import 'package:creditbank/screens/profile/profile_screen.dart';
import 'package:creditbank/screens/solscreen/sol_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Credit Bank',
        // darkTheme: ThemeData.dark(),
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          appBarTheme: AppBarTheme(color: kPrimaryColor),
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        ),
        home: HomeScreen());
  }
}
