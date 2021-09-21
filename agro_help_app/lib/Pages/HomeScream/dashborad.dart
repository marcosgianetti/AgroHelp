import 'package:agro_help_app/Pages/Disease/List/listDesease.dart';
import 'package:flutter/material.dart';
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
            /*   Container(
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.greenAccent.shade700,
                    Colors.white,
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 8, 2),
                  child: _utils.simpleText(
                    'Bem vindo, Marcos',
                    fontSize: 20,
                  ),
                ),
              ),
            ),*/
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
        InkWell(
          child: cardImage('assets/img/icons/apple.png', color: Colors.red.shade100, name: 'Maçã'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitImage(selected: 0)));
          },
        ),
        InkWell(
          child: cardImage('assets/img/icons/corn.png', color: Colors.yellow.shade100, name: 'Milho'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitImage(selected: 1)));
          },
        ),
        InkWell(
          child: cardImage('assets/img/icons/grape.png', color: Colors.purple.shade100, name: 'Uva'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitImage(selected: 2)));
          },
        ),
        InkWell(
          child: cardImage('assets/img/icons/tomato.png', color: Colors.red.shade100, name: 'Tomate'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitImage(selected: 3)));
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
