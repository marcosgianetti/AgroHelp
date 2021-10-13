import 'package:agro_help_app/Pages/Splash/splash.dart';
import 'package:agro_help_app/Pages/utils.dart';
import 'package:agro_help_app/provider/diseaseProvider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'provider/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DiseaseProvider()),
      ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
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
        primaryColorDark: Colors.green.shade700,
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
}
