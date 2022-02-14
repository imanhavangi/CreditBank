import 'dart:convert';

import 'package:creditbank/constants.dart';
import 'package:creditbank/screens/home/home.dart';
import 'package:creditbank/screens/login/login_screen.dart';
import 'package:creditbank/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

Future<UserSignup> createUserSignup(String email, String password,
    String password_confirmation, String first_name, String last_name) async {
  Response response = (await Dio().post(
    'https://creditbank.ir/app/api/register',
    data: {
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'first_name': first_name,
      'last_name': last_name,
    },
    options: Options(
        headers: {
          'Accept': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        }),
  ));
  // final http.Response response = await http.post(
  //   Uri.parse('https://creditbank.ir/app/api/register'),
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  //   body: jsonEncode(<String, String>{
  //     'email': email,
  //     'password': password,
  //     'password_confirmation': password_confirmation,
  //     'first_name': first_name,
  //     'last_name': last_name,
  //   }),
  // );
  print(response.statusCode);
  if (response.statusCode == 200) {
    // print('object');
    return UserSignup.fromJson((response.data));
  } else {
    throw Exception('Failed to Login User.');
  }
}

class UserSignup {
  final data;

  UserSignup({required this.data});

  factory UserSignup.fromJson(Map<String, dynamic> json) {
    return UserSignup(
      data: json,
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
    bool emailError = false;
    String emailErrorMsg;
    bool passError = false;
    String passErrorMsg;
    return Column(
      children: <Widget>[
        Expanded(child: topClip(size)),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
          child: Column(
            textDirection: TextDirection.rtl,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: first_nameController,
                decoration: const InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  prefixIcon: Icon(Icons.person),
                  hintText: 'نام',
                  hintStyle: TextStyle(fontFamily: 'iransans'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: last_nameController,
                decoration: const InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: 'نام خانوادگی',
                  hintStyle: TextStyle(fontFamily: 'iransans'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: emailController,
                decoration: const InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  prefixIcon: Icon(Icons.email),
                  hintText: 'ایمیل',
                  hintStyle: TextStyle(fontFamily: 'iransans'),
                  // errorText: "!ایمیل قبلا انتخاب شده است",
                  // errorText: emailErrorMsg,
                ),
                // textInputAction: TextInputAction.next,
                // validator: (value) {
                //   if (emailError) {
                //     emailError = false;
                //     return "!ایمیل قبلا انتخاب شده است";
                //   } else {
                //     return null;
                //   }
                // },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: passwordController,
                decoration: const InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'رمز عبور',
                  hintStyle: TextStyle(fontFamily: 'iransans'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: password_confirmationController,
                decoration: const InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'تکرار رمز عبور',
                  hintStyle: TextStyle(fontFamily: 'iransans'),
                  // errorText: "!رمز عبور با فیلد تکرار مطابقت ندارد"\
                ),
              ),
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: TextButton(
              //     onPressed: () {},
              //     child: const Text(
              //       'رمز خود را فراموش کرده اید؟',
              //       style: TextStyle(fontFamily: 'iransans'),
              //     ),
              //   ),
              // ),
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
                  print('sag');

                  // (_futureSignup != null)
                  //     ? FutureBuilder<UserSignup>(
                  //         future: _futureSignup,
                  //         builder: (context, snapshot) {
                  //           if (snapshot.hasData) {
                  //             print('has data');
                  //             if (snapshot.data!.data['ok']) {
                  //               Services.setToken(
                  //                   snapshot.data!.data['accessToken']);
                  //             } else {
                  //               try {
                  //                 print('sagsagsag');
                  //                 if (snapshot.data!.data['data']['email'][0] ==
                  //                     "ایمیل قبلا انتخاب شده است.") {
                  //                   setState(() {
                  //                     print('object');
                  //                     emailError = true;
                  //                   });
                  //                 }
                  //               } catch (e) {}
                  //             }
                  //           } else if (snapshot.hasError) {
                  //             // return Text("${snapshot.error}");
                  //             showDialog(
                  //                 context: context,
                  //                 builder: (BuildContext context) {
                  //                   return AlertDialog(
                  //                     content: Text("!لطفا دوباره امتحان کنید"),
                  //                   );
                  //                 });
                  //           }
                  //           return CircularProgressIndicator();
                  //         },
                  //       )
                  //     : {print("fuckfuckfuck")};

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
                                      if (snapshot.data!.data['ok']) {
                                        Services.setToken(
                                            snapshot.data!.data['accessToken']);
                                        return Container(
                                          height: 100,
                                          width: 100,
                                          child: Column(
                                            children: [
                                              Text('ورود با موفقیت انجام شد!'),
                                              ElevatedButton(
                                                  onPressed: () =>
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  HomeScreen())),
                                                  child: Text(
                                                      'انتقال به صفحه اصلی')),
                                            ],
                                          ),
                                        );
                                      } else {
                                        // print(snapshot.data!.data['data'].toString().contains(other));
                                        return Container(
                                          height: 100,
                                          width: 200,
                                          child: Column(
                                            children: <Widget>[
                                              // print('sagsagsag');
                                              (snapshot.data!.data['data']
                                                      .toString()
                                                      .contains("email"))
                                                  ?
                                                  // setState(() {
                                                  //   print('object');
                                                  //   emailError = true;
                                                  // });
                                                  Text(
                                                      'ایمیل قبلا انتخاب شده است.',
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    )
                                                  : Container(),
                                              // print('sagsagsag');
                                              // print()
                                              (snapshot.data!.data['data']
                                                      .toString()
                                                      .contains("password"))
                                                  ?
                                                  // setState(() {
                                                  //   print('object');
                                                  //   emailError = true;
                                                  // });
                                                  Text(
                                                      'رمز عبور با فیلد تکرار مطابقت ندارد.',
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        );
                                      }
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    return CircularProgressIndicator();
                                  },
                                ),
                        );
                      });
                },
                child: const Text(
                  'ثبت نام',
                  style: TextStyle(fontFamily: 'iransans'),
                ),
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
                child: const Text(
                  'ورود',
                  style: TextStyle(fontFamily: 'iransans'),
                ),
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
