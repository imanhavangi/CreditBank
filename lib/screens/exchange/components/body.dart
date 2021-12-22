import 'package:creditbank/constants.dart';
import 'package:creditbank/screens/creditcard/components/body.dart';
import 'package:creditbank/screens/exchange/components/buy.dart';
import 'package:creditbank/screens/exchange/components/sell.dart';
import 'package:creditbank/screens/price/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController price1 = TextEditingController();
  TextEditingController price2 = TextEditingController();
  double now = 0;

  List<bool> isSelected = [true, false];
  List<bool> coinList = [];
  @override
  Widget build(BuildContext context) {
    Future<Profile> futurePrice = getProfile();

    return Column(children: <Widget>[
      SizedBox(
        height: 20,
      ),
      Container(
        padding: EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 5),
        // color: Colors.grey,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          // border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ToggleButtons(
            isSelected: isSelected,
            color: Colors.grey,
            constraints: BoxConstraints.expand(
                height: 30, width: MediaQuery.of(context).size.width / 3),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            textStyle: TextStyle(
              // fontWeight: FontWeight.w700,
              // fontFamily: 'OpenSans',
              color: Colors.black,
              fontSize: 17,
            ),
            selectedColor: Colors.black,
            fillColor: Colors.white,
            children: <Widget>[
              Text('خرید'),
              Text('فروش'),
            ],
            onPressed: (int index) {
              setState(() {
                for (int buttonIndex = 0;
                    buttonIndex < isSelected.length;
                    buttonIndex++) {
                  if (buttonIndex == index) {
                    isSelected[buttonIndex] = true;
                  } else {
                    isSelected[buttonIndex] = false;
                  }
                }
                if (index == 0) {
                  print('خرید');
                  print(isSelected);
                } else {
                  print('فروش');
                  print(isSelected);
                }
              });
            }),
      ),
      // SizedBox(
      //   height: 50,
      // ),
      SizedBox(
        height: 50,
      ),
      buildTitle('مرحله اول', 'ارز مورد نظر خود را انتخاب نمایید'),
      Container(
        height: 90,
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
        child: ListView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          // shrinkWrap: true,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // textDirection: TextDirection.rtl,
          children: <Widget>[
            buildCoin('assets/coins/BTC.png', 'بیت کوین', 'BTC', 0),
            buildCoin('assets/coins/ETH.png', 'اتریوم', 'ETH', 1),
            buildCoin('assets/coins/USDT.png', 'تتر', 'USDT', 2),
            buildCoin('assets/coins/TRX.png', 'ترون', 'TRX', 3),
            buildCoin('assets/coins/DOGE.png', 'دوج کوین', 'DOGE', 4),
          ],
        ),
      ),
      SizedBox(
        height: 30,
      ),
      buildTitle('مرحله دوم', 'مقدار را وارد نمایید'),
      SizedBox(
        height: 20,
      ),
      Stack(
        children: <Widget>[
          isSelected[1]
              ? Column(
                  children: <Widget>[
                    buildField(price1),
                    SizedBox(
                      height: 15,
                    ),
                    buildField1(price2),
                  ],
                )
              : Column(
                  children: <Widget>[
                    buildField1(price1),
                    SizedBox(
                      height: 15,
                    ),
                    buildField(price2),
                  ],
                ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 5 * 4,
              top: 37,
            ),
            height: 40,
            width: 40,
            // padding: EdgeInsets.all(),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: kPrimaryColor),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/exchange.png'), scale: 20),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 30,
      ),
      Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        // width: MediaQuery.of(context).size.width / 3 * 2,
        height: 40,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: kPrimaryColor),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text('مبادله'),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.shopping_cart_outlined),
              ],
            )),
      ),
      SizedBox(
        height: 20,
      ),
      Container(
        margin: EdgeInsets.only(left: 40, right: 40),
        height: 100,
        color: kPrimaryColor.withOpacity(0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text(
                  coinList[0]
                      ? 'قیمت بیت کوین: '
                      : coinList[1]
                          ? 'قیمت اتریوم: '
                          : coinList[2]
                              ? 'قیمت تتر: '
                              : coinList[3]
                                  ? 'قیمت ترون: '
                                  : 'قیمت دوج کوین: ',
                  textDirection: TextDirection.rtl,
                ),
                FutureBuilder<Price>(
                  future: getPrice(coinList[0]
                      ? 'BTC'
                      : coinList[1]
                          ? 'ETH'
                          : coinList[2]
                              ? 'USDT'
                              : coinList[3]
                                  ? 'TRX'
                                  : 'DOGE'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      now = double.parse(snapshot.data!.irt);
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
            isSelected[1]
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text(
                        coinList[0]
                            ? 'موجودی بیت کوین: '
                            : coinList[1]
                                ? 'موجودی اتریوم: '
                                : coinList[2]
                                    ? 'موجودی تتر: '
                                    : coinList[3]
                                        ? 'موجودی ترون: '
                                        : 'موجودی دوج کوین: ',
                        textDirection: TextDirection.rtl,
                      ),
                      Text("0"),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text(
                        'موجودی تومان: ',
                        textDirection: TextDirection.rtl,
                      ),
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
                    ],
                  ),
          ],
        ),
      )
    ]);
  }

  Padding buildField(TextEditingController price) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Container(
        padding: EdgeInsets.all(8),
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: kPrimaryColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: <Widget>[
            Text(
              coinList[0]
                  ? 'بیت کوین'
                  : coinList[1]
                      ? 'اتریوم'
                      : coinList[2]
                          ? 'تتر'
                          : coinList[3]
                              ? 'ترون'
                              : 'دوج کوین',
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                // color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(coinList[0]
                        ? 'assets/coins/BTC.png'
                        : coinList[1]
                            ? 'assets/coins/ETH.png'
                            : coinList[2]
                                ? 'assets/coins/USDT.png'
                                : coinList[3]
                                    ? 'assets/coins/TRX.png'
                                    : 'assets/coins/DOGE.png')),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 1,
              color: kPrimaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              // height: 500,
              // width: 200,
              child: TextField(
                maxLines: 1,
                controller: price1,
                onChanged: (value) async {
                  print(now);
                  value != ""
                      ? price2.text = (double.parse(value) * now).toString()
                      : price2.text = "";
                },
                // color: Colors.black,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  // labelText: 'Enter Name',
                  // hintText: 'Enter Your Name'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildField1(TextEditingController price) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Container(
        padding: EdgeInsets.all(8),
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: kPrimaryColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: <Widget>[
            Text('تومان'),
            SizedBox(
              width: 5,
            ),
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                // color: Colors.white,
                shape: BoxShape.circle,
                image:
                    DecorationImage(image: AssetImage('assets/coins/IRT.png')),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 1,
              color: kPrimaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              // height: 500,
              // width: 200,
              child: TextField(
                controller: price2,
                // color: Colors.black,
                onChanged: (value) async {
                  value != ""
                      ? price1.text = (double.parse(value) / now).toString()
                      : price1.text = "";
                },
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  // labelText: 'Enter Name',
                  // hintText: 'Enter Your Name'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            subtitle,
            style: TextStyle(color: kPrimaryColor.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }

  Stack buildCoin(String icon, String name, String coin, int index) {
    coinList.add(false);
    return Stack(
      textDirection: TextDirection.rtl,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () async {
              setState(
                () {
                  for (var i = 0; i < coinList.length; i++) {
                    coinList[i] = false;
                  }
                  coinList[index] = true;
                },
              );
              now = double.parse((await getPrice(coinList[0]
                      ? 'BTC'
                      : coinList[1]
                          ? 'ETH'
                          : coinList[2]
                              ? 'USDT'
                              : coinList[3]
                                  ? 'TRX'
                                  : 'DOGE'))
                  .irt);
            },
            child: Container(
              padding: EdgeInsets.all(3),
              // height: 70,
              width: 70,
              decoration: BoxDecoration(
                  // color: Colors.black,
                  border: Border.all(
                      color: coinList[index] ? kPrimaryColor : Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage(icon)),
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    coin,
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ),
        coinList[index]
            ? Container(
                // height: 25,
                // width: 25,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 20,
                ),
              )
            : Container(),
      ],
    );
  }
}
