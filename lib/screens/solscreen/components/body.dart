import 'package:creditbank/constants.dart';
import 'package:creditbank/screens/login/login_screen.dart';
import 'package:creditbank/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Expanded(child: topClip(size)),
        Padding(
          padding:
              const EdgeInsets.only(left: 50, right: 50, bottom: 20, top: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  'ورود',
                  style: TextStyle(fontFamily: 'iransans'),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(size.width, 50), primary: kPrimaryColor),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: Text(
                  'ثبت نام',
                  style: TextStyle(fontFamily: 'iransans'),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(size.width, 50),
                    primary: Colors.white,
                    onPrimary: kPrimaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  topClip(Size size) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            kPrimaryColor,
            kPrimaryColor.withOpacity(0.8),
          ], begin: Alignment.topLeft),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 4, size.height - 120, size.width / 2, size.height - 60);
    path.quadraticBezierTo(
        size.width / 4 * 3, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
