import 'package:agro_help_app/Pages/HomeScream/dashborad.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agro Help',
      theme: ThemeData(
        //bottomAppBarColor: Colors.red,
        buttonColor: Colors.purpleAccent,
        primaryColor: Colors.blueAccent.shade200,
        primaryColorDark: Colors.blueAccent.shade700,
        primarySwatch: Colors.green,
        cardColor: Colors.green.shade50,
        // splashColor: Colors.red,
        secondaryHeaderColor: Colors.red.shade700,
        shadowColor: Colors.green.shade500,
        //canvasColor: Colors.amber.shade50,
        //indicatorColor: Colors.red,
        //selectedRowColor: Colors.red,
        hintColor: Colors.greenAccent.shade700,
        backgroundColor: Colors.blueAccent.shade200,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //brightness: Brightness,
      ),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: DashBoard(),
    );
  }
}
