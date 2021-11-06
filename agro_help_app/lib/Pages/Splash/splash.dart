import 'package:agro_help_app/Pages/Login/login_home.dart';
import 'package:agro_help_app/Pages/utils.dart';
import 'package:flutter/material.dart';

Utils _utils = new Utils();

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToDashBoard();
  }

  _navigateToDashBoard() async {
    await Future.delayed(Duration(milliseconds: 1600), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginHome(context)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/img/logo.png',
                width: MediaQuery.of(context).size.width / 2, height: MediaQuery.of(context).size.height / 2),
            _utils.simpleText(_utils.name(), fontSize: 48, color: Colors.white, fontWeight: FontWeight.w900),
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
