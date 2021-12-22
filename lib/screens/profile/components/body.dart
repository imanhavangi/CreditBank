import 'package:creditbank/constants.dart';
import 'package:creditbank/screens/cash/cash.dart';
import 'package:creditbank/screens/creditcard/components/body.dart';
import 'package:creditbank/screens/creditcard/creditcard.dart';
import 'package:creditbank/screens/home/home.dart';
import 'package:flutter/foundation.dart';
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
        Padding(
          padding: EdgeInsets.only(top: 30, left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FutureBuilder<Profile>(
                    future: futurePrice,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Text(snapshot.data!.user['name']),
                            Text(
                              'تایید شده',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
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
                  // Column(
                  //   // mainAxisAlignment: MainAxisAlignment.,
                  //   textDirection: TextDirection.rtl,
                  //   children: <Widget>[
                  //     Text('ایمان هاونگی'),
                  //     Text(
                  //       'تایید شده',
                  //       textAlign: TextAlign.end,
                  //       style: TextStyle(
                  //         color: Colors.green,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    // padding: EdgeInsets.all(10),
                    // alignment: Alignment.center,
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage("profile.png")),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CashScreen(),
                ));
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.white, onPrimary: Colors.black),
          child: Container(
            height: 60,
            // padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CashScreen(),
                              ));
                        },
                        icon: Icon(Icons.chevron_left_outlined)),
                    Text('تومان'),
                    FutureBuilder<Profile>(
                      future: futurePrice,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data!.wallets["total_assets"]
                              .toString());
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return JumpingDotsProgressIndicator(
                          fontSize: 20.0,
                        );
                      },
                    ),
                    // Text('0'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('موجودی حساب'),
                    SizedBox(
                      width: 17,
                    ),
                    Icon(Icons.account_balance_wallet_outlined),
                  ],
                )
              ],
            ),
          ),
        ),
        rowButtonBuilder('مالی', Icons.calculate_outlined, () {}),
        rowButtonBuilder('سفارشات', Icons.local_mall_outlined, () {}),
        rowButtonBuilder(
            'حساب های بانکی',
            Icons.credit_card_outlined,
            () => {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreditCardScreen(),
                  ))
                }),
        rowButtonBuilder('تیکت ها', Icons.forum_outlined, () {}),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              primary: Colors.white, onPrimary: Colors.black),
          child: Container(
            height: 60,
            // padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('خروج از حساب'),
                SizedBox(
                  width: 17,
                ),
                Icon(Icons.logout_outlined),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ElevatedButton rowButtonBuilder(
      String text, IconData icon, Function function) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.white, onPrimary: kPrimaryColor),
      child: Container(
        // color: Colors.black,
        height: 60,
        // padding: EdgeInsets.only(left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.chevron_left_outlined)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  text,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  icon,
                  color: kPrimaryColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
