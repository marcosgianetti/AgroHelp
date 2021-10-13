import 'package:agro_help_app/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

Utils _utils = new Utils();

class GoogleSingUp extends StatelessWidget {
  const GoogleSingUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/logo.png',
                width: MediaQuery.of(context).size.width / 2, height: MediaQuery.of(context).size.height / 2),
            _utils.simpleText('AGRO HELP', fontSize: 48, color: Colors.white, fontWeight: FontWeight.w900),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      //             primary: Colors.white,
                      //           onPrimary: Colors.black,
                      minimumSize: Size(MediaQuery.of(context).size.width - 80, 50)),
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.googleLogin();
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                  ),
                  label: _utils.simpleText('Sign Up with Google', fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
