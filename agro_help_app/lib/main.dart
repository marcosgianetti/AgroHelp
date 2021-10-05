import 'package:agro_help_app/Pages/Splash/splash.dart';
import 'package:agro_help_app/Pages/utils.dart';
import 'package:agro_help_app/povider/diseaseProvider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Pages/Dashboard/dashborad.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DiseaseProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  Utils _utils = new Utils();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agro Help',
      theme: ThemeData(
        buttonColor: Colors.purpleAccent,
        primaryColor: Colors.blueAccent.shade200,
        primaryColorDark: Colors.blueAccent.shade700,
        primarySwatch: Colors.green,
        cardColor: Colors.green.shade50,
        secondaryHeaderColor: Colors.red.shade700,
        shadowColor: Colors.green.shade500,
        hintColor: Colors.greenAccent.shade700,
        backgroundColor: Colors.blueAccent.shade200,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }

  Widget _splashScrean() {
    return Scaffold(
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/logo.png',
              width: 250,
              height: 250,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _utils.simpleText(
                'AGRO HELP',
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
