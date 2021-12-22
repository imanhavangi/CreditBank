import 'package:creditbank/constants.dart';
import 'package:creditbank/screens/creditcard/components/body.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Future<Profile> futurePrice = getProfile();
    return Column(
      children: <Widget>[
        Container(
          height: 150,
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          // margin: EdgeInsets.only(top: 50),
          child: Center(
              child: Column(
            textDirection: TextDirection.rtl,
            children: [
              Text("موجودی کل به تومان",
                  style: TextStyle(
                      fontFamily: "iransans",
                      fontSize: 20,
                      color: Colors.white)),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<Profile>(
                future: futurePrice,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                        snapshot.data!.wallets["total_assets"].toString() +
                            ' IRT',
                        style: TextStyle(
                            fontFamily: "iransans",
                            fontSize: 20,
                            color: Colors.white));
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return JumpingDotsProgressIndicator(
                    fontSize: 20.0,
                  );
                },
              ),
              // Text('16000' + ' IRT',
              //     style: TextStyle(
              //         fontFamily: "iransans",
              //         fontSize: 20,
              //         color: Colors.white)),
            ],
          )),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 20),
          child: FutureBuilder<Profile>(
            future: futurePrice,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    buildCashCoin(
                        'IRT',
                        'تومان',
                        'assets/coins/IRT.png',
                        snapshot.data!.wallets['summary']['IRT']['balance']
                            .toString()),
                    buildCashCoin(
                        'BTC',
                        'بیت کوین',
                        'assets/coins/BTC.png',
                        snapshot.data!.wallets['summary']['BTC']['balance']
                            .toString()),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return JumpingDotsProgressIndicator(
                fontSize: 20.0,
              );
            },
          ),
        ),
        // child: Column(
        // textDirection: TextDirection.rtl,
      ],
    );
  }

  Container buildCashCoin(String coin, String name, String image, String cash) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 60,
      child: Row(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Container(
            // padding: EdgeInsets.all(10),
            // alignment: Alignment.center,
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              // color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(image),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            name,
            style: TextStyle(fontFamily: "iransans", fontSize: 15),
          ),
          Expanded(
            child: Container(),
          ),
          Text(
            cash + " " + coin,
            style: TextStyle(fontFamily: "iransans", fontSize: 15),
          ),
        ],
      ),
    );
  }
}
