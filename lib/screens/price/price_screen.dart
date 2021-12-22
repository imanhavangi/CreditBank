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
      appBar: dAppBar(context),
      body: Body(),
    );
  }

  dAppBar(BuildContext context) {
    return AppBar(
      title: Text('قیمت لحظه ای ارز ها'),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.monetization_on_outlined),
        onPressed: () {},
      ),
    );
  }
}