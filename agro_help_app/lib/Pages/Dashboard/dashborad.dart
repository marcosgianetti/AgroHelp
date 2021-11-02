import 'package:agro_help_app/Pages/Disease/List/listDesease.dart';
import 'package:agro_help_app/Pages/Drawer/dashboard_drawer.dart';
import 'package:agro_help_app/api/firebase_api.dart';
import 'package:agro_help_app/model/firebase_file.dart';
import 'package:agro_help_app/provider/diseaseProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils.dart';

Utils _utils = new Utils();

class DashBoard extends StatelessWidget {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  Widget build(BuildContext context) {
    futureFiles = FirebaseApi.listAll('files/');

    //var height = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: _utils.simpleText("Agro Help", fontSize: 36, fontWeight: FontWeight.bold),
        actions: [Image.asset('assets/img/logo.png')],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 190, child: _imagensDashboard(context)),
            _newsDashboard(),
            //_buttonLoginOut(context),
            SizedBox(
              height: 32,
            )
          ],
        ),
      ),
      drawer: HomeDrawer(),
    );
  }

  Widget _newsDashboard() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('News').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.active:
            if (snapshot.hasData) {
              try {
                final docs = snapshot.data!.docs;

                return ListView.builder(
                    itemCount: docs.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: Card(child: _utils.newsCart(docs[i])),
                      );
                    });
              } catch (e) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Card(
                    child: _utils.simpleText(
                      'Erro ao carregar dados, verifique sua conexção com a internet! 1',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Card(
                child: _utils.simpleText(
                  'Erro ao carregar dados, verifique sua conexção com a internet! 2',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          default:
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Card(
                child: _utils.simpleText(
                  'Erro ao carregar dados, verifique sua conexção com a internet! 3',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
        }
      },
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
        leading: ClipOval(
          child: Image.network(
            file.url,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),
        title: _utils.simpleText(file.name),
      );

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
                fruit.fruit.changeName('Maçã');

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
            ListTile(
              title: Image.asset(
                imageRoute,
                height: 120,
                width: 120,
                fit: BoxFit.fitWidth,
              ),
            ),
            _utils.simpleText(name, fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)
          ],
        ),
        elevation: 8,
        shadowColor: color!,
        margin: EdgeInsets.all(8),
      ),
    );
  }
}
