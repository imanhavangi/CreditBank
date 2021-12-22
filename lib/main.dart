import 'package:creditbank/constants.dart';
import 'package:creditbank/screens/creditcard/creditcard.dart';
import 'package:creditbank/services.dart';
import 'package:creditbank/screens/home/home.dart';
import 'package:creditbank/screens/login/login_screen.dart';
import 'package:creditbank/screens/profile/profile_screen.dart';
import 'package:creditbank/screens/solscreen/sol_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String temp = await Services.getToken();
  runApp(MyApp(
    token: temp,
  ));
}

class MyApp extends StatefulWidget {
  String token;
  MyApp({Key? key, required this.token}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String token;

  void initState() {
    super.initState();
    token = widget.token;
    // token = '42|HxtbnWadadMhk4RGXmCfIsSyqbVxnKdWyQL041HM';
    print(token);
    // print(token);
  }

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
        home: token == '0' ? SolScreen() : HomeScreen());
    // home: const CreditCardScreen());
  }
}
