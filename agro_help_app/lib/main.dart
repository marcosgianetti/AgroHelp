import 'package:flutter/material.dart';
import 'Pages/SubmitImage/submitImage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Classification',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SubmitImage(),
    );
  }
}
