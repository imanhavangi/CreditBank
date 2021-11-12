import 'package:creditbank/constants.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        topClip(size),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email), hintText: 'Email'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Password',
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text('Forgot Password?'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Log In'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(size.width, 50), primary: kPrimaryColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey,
                      height: 1,
                      width: MediaQuery.of(context).size.width / 2 - 60,
                    ),
                    Text('or'),
                    Container(
                      color: Colors.grey,
                      height: 1,
                      width: MediaQuery.of(context).size.width / 2 - 60,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(size.width, 50),
                  primary: Colors.white,
                  onPrimary: kPrimaryColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  ClipPath topClip(Size size) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        height: size.height * 0.5,
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
