import 'package:agro_help_app/Pages/Dashboard/dashborad.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'google_login_screen.dart';

class LoginHome extends StatelessWidget {
  const LoginHome(BuildContext context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: Container(
                  color: Colors.white,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    value: 90,
                  ),
                ),
              );
            else if (snapshot.hasError)
              return Center(
                child: Text('Error: ${snapshot.error.toString()}'),
              );
            else if (snapshot.hasData)
              return DashBoard();
            else
              return GoogleSingUp();
          },
        ),
      );
}
