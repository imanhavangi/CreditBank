import 'dart:async';
import 'dart:convert';
import 'package:creditbank/constants.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:progress_indicators/progress_indicators.dart';

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
  final String irt;

  Price({required this.usd, required this.irt});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      usd: json["data"]["usd"].toString(),
      irt: json["data"]["irt"].toString(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 10), (Timer t) => checkForNewSharedLists());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void checkForNewSharedLists() {
    setState(() {
      // getPrice('BTC');
      // getPrice('ETH');
      // getPrice('USDT');
      // getPrice('TRX');
      // getPrice('DOGE');
    });
  }

  // late Future<Price> _futurePrice = getPrice("BTC");
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        coinPrice("بیت کوین", "assets/coins/BTC.png", getPrice('BTC')),
        coinPrice("اتریوم", "assets/coins/ETH.png", getPrice('ETH')),
        coinPrice('تتر', 'assets/coins/USDT.png', getPrice('USDT')),
        coinPrice('ترون', 'assets/coins/TRX.png', getPrice('TRX')),
        coinPrice('دوج کوین', 'assets/coins/DOGE.png', getPrice('DOGE')),
      ],
    );
  }

  Padding coinPrice(String name, String image, Future<Price> _futurePrice) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 10),
        decoration: BoxDecoration(
            // border: Border.all(color: kPrimaryColor),
            color: kPrimaryColor.withOpacity(0.03),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        // height: 150,
        // color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder<Price>(
                  future: _futurePrice,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!.usd + " \$",
                        style: TextStyle(fontSize: 20.0),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return JumpingDotsProgressIndicator(
                      fontSize: 20.0,
                    );
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                FutureBuilder<Price>(
                  future: _futurePrice,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!.irt + " IRT",
                        style: TextStyle(fontSize: 15.0),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return JumpingDotsProgressIndicator(
                      fontSize: 20.0,
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  // padding: EdgeInsets.all(10),
                  // alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage(image)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
