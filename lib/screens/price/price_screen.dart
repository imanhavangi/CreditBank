import 'package:flutter/material.dart';
import 'components/body.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({ Key? key }) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('data'),),
      body: Body(),
    );
  }
}