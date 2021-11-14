import 'package:agro_help_app/Pages/Disease/List/listDesease.dart';
import 'package:agro_help_app/Pages/Drawer/dashboard_drawer.dart';
import 'package:agro_help_app/api/firebase_api.dart';
import 'package:agro_help_app/model/firebase_file.dart';
import 'package:agro_help_app/provider/diseaseProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils.dart';
import 'package:animations/animations.dart';

Utils _utils = new Utils();

class DashBoard extends StatelessWidget {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  Widget build(BuildContext context) {
    futureFiles = FirebaseApi.listAll('files/');

    return Scaffold(
      appBar: AppBar(
        title: _utils.simpleText(_utils.name(), fontSize: 36, fontWeight: FontWeight.bold),
        actions: [Image.asset('assets/img/logo.png')],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [SizedBox(height: 190, child: _imagensDashboard(context)), _newsDashboard(), SizedBox(height: 32)],
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

  Widget _imagensDashboard(BuildContext context) {
    return Consumer<DiseaseProvider>(builder: (context, fruit, child) {
      return ListView(
        // alignment: WrapAlignment.center,
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          cardImage('assets/img/icons/apple.png',
              fruit: fruit, color: Colors.red.shade100, name: 'Maçã', submitImage: SubmitImage(selected: 0)),
          cardImage('assets/img/icons/corn.png',
              color: Colors.yellow.shade100, name: 'Milho', fruit: fruit, submitImage: SubmitImage(selected: 1)),
          cardImage('assets/img/icons/grape.png',
              color: Colors.purple.shade100, name: 'Uva', fruit: fruit, submitImage: SubmitImage(selected: 2)),
          cardImage('assets/img/icons/tomato.png',
              color: Colors.red.shade100, name: 'Tomate', fruit: fruit, submitImage: SubmitImage(selected: 3)),
        ],
      );
    });
  }

  Widget cardImage(
    String imageRoute, {
    @required Color? color,
    @required SubmitImage? submitImage,
    @required DiseaseProvider? fruit,
    @required String? name,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OpenContainer(
        closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
        transitionDuration: Duration(milliseconds: 560),
        closedColor: color!,
        openBuilder: (context, _) {
          fruit!.fruit.changeName(name!);
          return SubmitImage(selected: 0);
        },
        closedBuilder: (context, VoidCallback openContainer) => GestureDetector(
          onTap: openContainer,
          child: Container(
            width: 136,
            child: Column(
              children: [
                ListTile(title: Image.asset(imageRoute, height: 110, width: 110, fit: BoxFit.fitWidth)),
                _utils.simpleText(name!, fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
