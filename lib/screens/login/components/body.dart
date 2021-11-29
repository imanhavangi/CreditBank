import 'dart:convert';

import 'package:creditbank/constants.dart';
import 'package:creditbank/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<UserLogin> createUserLogin(String email, String password) async {
  final http.Response response = await http.post(
    Uri.parse('https://creditbank.ir/app/api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    return UserLogin.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to Login User.');
  }
}

class UserLogin {
  final String token;

  UserLogin({required this.token});

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      token: json['accessToken'],
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<UserLogin> _futureLogin;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Column(
      children: <Widget>[
        Expanded(child: topClip(size)),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email), hintText: 'Email'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Password',
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  print(emailController.text);
                  print(passwordController.text);
                  _futureLogin =
                      createUserLogin(emailController.text, passwordController.text);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: (_futureLogin == null)
                              ? Text('data')
                              : FutureBuilder<UserLogin>(
                                  future: _futureLogin,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data!.token);
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    return CircularProgressIndicator();
                                  },
                                ),
                        );
                      });
                },
                child: const Text('Log In'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(size.width, 50), primary: kPrimaryColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey,
                      height: 1,
                      width: MediaQuery.of(context).size.width / 2 - 60,
                    ),
                    Text('or'),
                    Container(
                      color: Colors.grey,
                      height: 1,
                      width: MediaQuery.of(context).size.width / 2 - 60,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(size.width, 50),
                  primary: Colors.white,
                  onPrimary: kPrimaryColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  ClipPath topClip(Size size) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            kPrimaryColor,
            kPrimaryColor.withOpacity(0.8),
          ], begin: Alignment.topLeft),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 4, size.height - 120, size.width / 2, size.height - 60);
    path.quadraticBezierTo(
        size.width / 4 * 3, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
