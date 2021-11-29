import 'package:creditbank/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
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
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text('ایمان هاونگی'),
                      Text(
                        'تایید شده',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
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
          onPressed: () {},
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
                        onPressed: () {},
                        icon: Icon(Icons.chevron_left_outlined)),
                    Text('تومان'),
                    Text('0'),
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
        rowButtonBuilder('حساب های بانکی', Icons.credit_card_outlined, () {}),
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
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('sala'),
              );
            });
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
