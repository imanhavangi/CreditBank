import 'package:flutter/material.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({ Key? key }) : super(key: key);

  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            color: Colors.green,
          )
        ],
      ),
    );
  }
}