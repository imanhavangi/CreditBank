import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

Future<Price> getPrice(String coin) async {
  // final http.Response response = await http.post(
  //   Uri.parse('https://creditbank.ir/api/crypto/price/$coin'),
// );
  var dio = Dio();
  final response =
      await dio.get('https://creditbank.ir/api/crypto/price/$coin');

  if (response.statusCode == 200) {
    print(response.data);
    return Price.fromJson(response.data);
  } else {
    throw Exception('Failed to Login User.');
  }
}

class Price {
  final String usd;

  Price({required this.usd});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      usd: json["data"]["usd"].toString(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<Price> _futurePrice = getPrice("BTC");
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Price>(
      future: _futurePrice,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.usd);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
