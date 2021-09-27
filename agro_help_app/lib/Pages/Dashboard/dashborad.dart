import 'package:agro_help_app/Pages/Disease/List/listDesease.dart';
import 'package:agro_help_app/povider/diseaseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils.dart';

Utils _utils = new Utils();

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: _utils.simpleText(
          "Agro Help",
          fontSize: 36,
        ),
        actions: [Image.asset('assets/img/logo.png')],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 190, child: _imagensDashboard(context)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: height / 2.5,
                width: width - 100,
                color: Colors.amber.shade100,
                child: Center(
                  child: Text('Clima'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: height / 2.5,
                width: width - 100,
                color: Colors.amber.shade100,
                child: Center(
                  child: Text('Noticias'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagensDashboard(BuildContext context) {
    return ListView(
      // alignment: WrapAlignment.center,
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Consumer<DiseaseProvider>(
          builder: (context, fruit, child) {
            return InkWell(
              child: cardImage('assets/img/icons/apple.png', color: Colors.red.shade100, name: 'Maçã'),
              onTap: () {
                fruit.fruit.changeName('Maça');

                Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitImage(selected: 0)));
              },
            );
          },
        ),
        Consumer<DiseaseProvider>(
          builder: (context, fruit, child) {
            return InkWell(
              child: cardImage('assets/img/icons/corn.png', color: Colors.yellow.shade100, name: 'Milho'),
              onTap: () {
                fruit.fruit.changeName('Milho');

                Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitImage(selected: 1)));
              },
            );
          },
        ),
        Consumer<DiseaseProvider>(
          builder: (context, fruit, child) {
            return InkWell(
              child: cardImage('assets/img/icons/grape.png', color: Colors.purple.shade100, name: 'Uva'),
              onTap: () {
                fruit.fruit.changeName('Uva');

                Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitImage(selected: 2)));
              },
            );
          },
        ),
        Consumer<DiseaseProvider>(
          builder: (context, fruit, child) {
            return InkWell(
              child: cardImage('assets/img/icons/tomato.png', color: Colors.red.shade100, name: 'Tomate'),
              onTap: () {
                fruit.fruit.changeName('Tomate');

                Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitImage(selected: 3)));
              },
            );
          },
        ),
      ],
    );
  }

  Widget cardImage(String imageRoute, {@required Color? color, String name = ""}) {
    return Container(
      width: 130,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: color,
        child: Column(
          children: [
            Container(
              child: ListTile(
                title: Image.asset(
                  imageRoute,
                  height: 120,
                  width: 120,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            _utils.simpleText(name, fontSize: 18, fontWeight: FontWeight.bold)
          ],
        ),
        elevation: 8,
        shadowColor: color!,
        margin: EdgeInsets.all(8),
      ),
    );
  }
}
