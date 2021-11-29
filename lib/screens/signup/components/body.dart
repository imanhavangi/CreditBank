import 'dart:convert';

import 'package:creditbank/constants.dart';
import 'package:creditbank/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<UserSignup> createUserSignup(String email, String password,
    String password_confirmation, String first_name, String last_name) async {
  final http.Response response = await http.post(
    Uri.parse('https://creditbank.ir/app/api/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'first_name': first_name,
      'last_name': last_name,
    }),
  );

  if (response.statusCode == 200) {
    return UserSignup.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to Login User.');
  }
}

class UserSignup {
  final String token;

  UserSignup({required this.token});

  factory UserSignup.fromJson(Map<String, dynamic> json) {
    return UserSignup(
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
  late Future<UserSignup> _futureSignup;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController first_nameController = TextEditingController();
    TextEditingController last_nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController password_confirmationController =
        TextEditingController();
    return Column(
      children: <Widget>[
        Expanded(child: topClip(size)),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextFormField(
                controller: first_nameController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person), hintText: 'First Name'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: last_nameController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: 'Last Name'),
              ),
              const SizedBox(
                height: 20,
              ),
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
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: password_confirmationController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Confirm Password',
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
                  _futureSignup = createUserSignup(
                      emailController.text,
                      passwordController.text,
                      password_confirmationController.text,
                      first_nameController.text,
                      last_nameController.text);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: (_futureSignup == null)
                              ? Text('data')
                              : FutureBuilder<UserSignup>(
                                  future: _futureSignup,
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
                child: const Text('Sign Up'),
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
                    const Text('or'),
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
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text('Log In'),
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
