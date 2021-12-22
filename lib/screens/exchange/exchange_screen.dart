import 'package:flutter/material.dart';
import 'components/body.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({Key? key}) : super(key: key);

  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: dAppBar(context),
        body: Body(),
      ),
    );
  }

  dAppBar(BuildContext context) {
    return AppBar(
      title: Text('خرید و فروش'),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.monetization_on_outlined),
        onPressed: () {},
      ),
    );
  }
}
