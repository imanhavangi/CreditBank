import 'package:flutter/material.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({ Key? key }) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
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