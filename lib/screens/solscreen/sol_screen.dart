import 'package:creditbank/constants.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class SolScreen extends StatelessWidget {
  const SolScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // primary: kPrimaryColor,
      // backgroundColor: kPrimaryColor.withOpacity(0.5),
      appBar: buildAppBar(),
      body: const Body(),
    );
  }

  buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: Icon(Icons.monetization_on_outlined),
    );
  }
}
