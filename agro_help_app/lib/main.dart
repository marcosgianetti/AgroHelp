import 'package:agro_help_app/Pages/HomeScream/dashborad.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agro Help',
      theme: ThemeData(
          //bottomAppBarColor: Colors.red,
          buttonColor: Colors.purpleAccent,
          primaryColor: Colors.amber.shade600,
          primaryColorDark: Colors.amber.shade700,
          primarySwatch: Colors.green,
          // cardColor: Colors.red,
          // splashColor: Colors.red,
          secondaryHeaderColor: Colors.green.shade700,
          shadowColor: Colors.amber.shade900,
          //canvasColor: Colors.amber.shade50,
          //indicatorColor: Colors.red,
          //  selectedRowColor: Colors.red,
          hintColor: Colors.greenAccent.shade700,
          backgroundColor: Colors.orangeAccent.shade100),
      debugShowCheckedModeBanner: false,
      home: DashBoard(),
    );
  }
}
