import 'dart:ui';

import 'package:creditbank/constants.dart';
import 'package:creditbank/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

Future<Profile> getProfile() async {
  // final http.Response response = await http.post(
  //   Uri.parse('https://creditbank.ir/api/crypto/price/$coin'),
// );
  var dio = Dio();
  // print("4 bilion"+ await Services.getToken());
  dio.options.headers['Authorization'] =
      'Bearer 42|HxtbnWadadMhk4RGXmCfIsSyqbVxnKdWyQL041HM';
  // dio.options.headers['token'] = '${Services.getToken()}';

  final response = await dio.get('https://creditbank.ir/app/api/me');
  print(response.data["data"]["user"]["bank_cards"]);

  if (response.statusCode == 200) {
    // print(response.data.toString());
    return Profile.fromJson(response.data);
  } else {
    throw Exception('Failed to Login User.');
  }
}

class Profile {
  final creditcards;
  final wallets;
  final user;

  Profile(
      {required this.creditcards, required this.wallets, required this.user});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      // creditcards: json["data"]["user"]["bank_cards"],
      creditcards: json["data"]["user"]["bank_cards"],
      wallets: json["data"]["wallets_summary"],
      user: json["data"]["user"],
      // irt: json["data"]["irt"].toString(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // getPrice();
    Future<Profile> futurePrice = getProfile();
    return Column(
      children: <Widget>[
        FutureBuilder<Profile>(
          future: futurePrice,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("sag sag");
              for (var i = 0;
                  i < (snapshot.data!.creditcards as List).length;
                  i++) {
                print("object");
                // if (snapshot.data!.creditcards is String) {
                //   print('madar sag');
                // }
                return createCreditCard(
                    snapshot.data!.creditcards[i]["card_number"],
                    snapshot.data!.creditcards[i]["computed_bank"],
                    snapshot.data!.creditcards[i]["computed_status"]);
              }
              // return Text(
              //   snapshot.data!.creditcards + " \$",
              //   style: TextStyle(fontSize: 20.0),
              // );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return JumpingDotsProgressIndicator(
              fontSize: 20.0,
            );
          },
        ),
        // createCreditCard('5859831156509126', 'بانک تجارت', 'تایید شده'),
        // createCreditCard(),
      ],
    );
  }

  Container createCreditCard(String number, String bank, String status) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 50),
      child: Stack(
        children: <Widget>[
          Container(
            height: 200,
            // color: Colors.black,
            decoration: BoxDecoration(
                // gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [kPrimaryColor, kPrimaryColor.withOpacity(0.8)]),
                gradient: LinearGradient(
                    colors: [kPrimaryColor, kPrimaryColor.withOpacity(0.8)]),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  number.substring(0, 4) +
                      " " +
                      number.substring(4, 8) +
                      " " +
                      number.substring(8, 12) +
                      " " +
                      number.substring(12, 16),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'kredit',
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      bank,
                      style: TextStyle(
                          color: Colors.white,
                          // fontSize: 20,
                          fontFamily: 'iransans'),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: status == 'تایید شده'
                                ? Colors.green
                                : Colors.red,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        status,
                        style: TextStyle(
                            color: status == 'تایید شده'
                                ? Colors.green
                                : Colors.red,
                            // fontSize: 20,
                            fontFamily: 'iransans'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
