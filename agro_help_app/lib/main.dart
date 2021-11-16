import 'package:agro_help_app/Pages/Splash/splash.dart';
import 'package:agro_help_app/Pages/utils.dart';
import 'package:agro_help_app/provider/diseaseProvider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'provider/google_sign_in.dart';

Utils _utils = Utils();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DiseaseProvider()),
      ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  //PALETA DE CORES
  //Color.fromRGBO(180, 219, 187, 1),
  //Color.fromRGBO(43, 56, 37, 1),
  //Color.fromRGBO(249, 255, 237, 1),
  //Color.fromRGBO(177, 195, 184, 1),
  //Color.fromARGB(105, 103, 88, 1),
  //Color.fromARGB(79, 115, 68, 1),
  //Color.fromRGBO(43, 56, 37, 1),

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _utils.name(),
      theme: ThemeData(
        brightness: Brightness.dark,
        //buttonColor: Color.fromARGB(79, 115, 68, 1),

        primaryColor: Color.fromRGBO(43, 56, 37, 1),
        cardColor: Color.fromRGBO(105, 103, 88, 1),
        scaffoldBackgroundColor: Color.fromRGBO(177, 195, 184, 1),
        secondaryHeaderColor: Color.fromRGBO(180, 219, 187, 1),
        shadowColor: Color.fromARGB(79, 115, 68, 1),
        //hintColor: Colors.greenAccent.shade700,
        //backgroundColor: Colors.blueAccent.shade200,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Splash(),
      // supportedLocales: const <Locale>[Locale('pt', 'BR')],
    );
  }
}
