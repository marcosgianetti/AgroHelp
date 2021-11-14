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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _utils.name(),
      theme: ThemeData(
        // buttonColor: Color.fromRGBO(69, 74, 245, 1),
        primaryColor: Colors.blueAccent.shade200,
        primaryColorDark: Colors.green.shade700,
        primarySwatch: Colors.green,
        cardColor: Colors.green.shade50,
        scaffoldBackgroundColor: Color.fromRGBO(177, 195, 184, 1),
        secondaryHeaderColor: Colors.red.shade700,
        shadowColor: Colors.green.shade500,
        hintColor: Colors.greenAccent.shade700,
        backgroundColor: Colors.blueAccent.shade200,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Splash(),
      // supportedLocales: const <Locale>[Locale('pt', 'BR')],
    );
  }
}
