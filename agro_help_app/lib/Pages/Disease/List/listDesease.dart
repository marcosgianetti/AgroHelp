import 'package:agro_help_app/Pages/Disease/Details/deseaseDetail.dart';
import 'package:agro_help_app/Pages/utils.dart';
import 'package:agro_help_app/api/firebase_api.dart';
import 'package:agro_help_app/model/firebase_file.dart';
import 'package:agro_help_app/povider/diseaseProvider.dart';
import 'package:agro_help_app/utils/doenca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';

import 'controllerSubmit.dart';

Utils _utils = new Utils();

class SubmitImage extends StatelessWidget {
  late int selected = 0;
  SubmitImage({this.selected: 0});
  late int example = 10;
  double witdh = 0.0;
  final controller = ControllerSumition();
  // late String _title;
  @override
  Widget build(BuildContext context) {
    witdh = MediaQuery.of(context).size.width;
    controller.modelSelected(selected);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: _utils.simpleText(Provider.of<DiseaseProvider>(context, listen: false).fruit.name,
              fontSize: 36, fontWeight: FontWeight.bold),
        ),
        actions: [Image.asset('assets/img/logo.png')],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
              child: Center(
                child: _utils.simpleText('Listagem de doenças', fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            _listdDeseas(context),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Apple_CedarAppleRust").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error ' + snapshot.error.toString());
                } else if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: docs.length,
                    itemBuilder: (_, i) {
                      //final data = docs[i].data();
                      return ListTile(
                        title: Text(docs[i]['caracteristica']),
                        subtitle: Text(docs[i]['combate'] + '\n' + docs[i]['evitar']),
                      );
                    },
                  );
                }
                return LinearProgressIndicator();
              },
            ),
            Observer(
              builder: (_) {
                return Text(
                  controller.category != null ? 'Confidence: ${controller.category!.score.toStringAsFixed(3)}' : '',
                  style: TextStyle(fontSize: 16),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
        child: Tooltip(
          message: "Classificar por imagem",
          child: ElevatedButton(
            onPressed: () {
              controller.getImage(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.camera_alt),
                ),
                _utils.simpleText("Classificar por imagem", color: Colors.white, fontSize: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _doencaCard(BuildContext context, {dynamic nomeDoenca}) {
    return Card(
      child: Container(
        width: witdh * 0.9,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue,
                child: SizedBox(
                  width: witdh * 0.2,
                  height: witdh * 0.3,
                ),
              ),
            ),
            Container(
              width: witdh * 0.7,
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.bottomLeft,
                      child: _utils.simpleText(
                        nomeDoenca['doenca'],
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                  _catacterisitica(doenca: nomeDoenca['doenca'])
                  //_utils.simpleText('A doenca x é causada por y, resultando em z', fontSize: 16)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listdDeseas(BuildContext context) {
//    Map<int, String> plantsList = {0: 'Apple', 1: 'Corn', 2: 'Grape', 3: 'Tomato'};

    try {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(Provider.of<DiseaseProvider>(context, listen: false).fruit.dbName)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _utils.simpleText('Error ' + snapshot.error.toString());
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return _utils.simpleText('Verifique sua conecxão com a internet');

            case ConnectionState.waiting:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearProgressIndicator(),
              );

            case ConnectionState.active:
              if (snapshot.hasData) {
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: docs.length,
                  itemBuilder: (_, i) {
                    return _doencaCard(context, nomeDoenca: docs[i]);
                  },
                );
              } else {
                return _utils.simpleText('Algo deu errado, tente mais tarde :(');
              }
            default:
              return _utils.simpleText('Algo deu errado, tente mais tarde :(');
          }
        },
      );
    } catch (e) {
      return _utils.simpleText('Algo deu errado, tente mais tarde :(');
    }
  }

  Widget _catacterisitica({String? doenca}) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(doenca!).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.active:
            if (snapshot.hasData) {
              try {
                final docs = snapshot.data!.docs;
                Disease disease = new Disease();
                disease.name = doenca;
                disease.caracteristc = docs[0].data()['caracteristica'] ?? 'Dados não definidos';
                disease.treatement = docs[0].data()['combate'] ?? 'Dados não definidos';
                disease.prevention = docs[0].data()['evitar'] ?? 'Dados não definidos';
                Provider.of<DiseaseProvider>(context, listen: false).fruit.desease.add(disease);

                return GestureDetector(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: _utils.simpleText(
                          'Caracteristica: ' + '${disease.caracteristc}',
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: _utils.simpleText(
                          'Combate: ' + '${disease.treatement}',
                          fontSize: 14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: _utils.simpleText(
                          'Prevenção: ' + '${disease.prevention}',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Provider.of<DiseaseProvider>(context, listen: false).changeSelectedDesease(disease);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DeseaseDetail()));
                  },
                );
              } catch (e) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: _utils.simpleText(
                    'Erro ao carregar dados, verifique sua conexção com a internet!',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                );
              }
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: _utils.simpleText(
                'Erro ao carregar dados, verifique sua conexção com a internet!',
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            );
          default:
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: _utils.simpleText(
                'Erro ao carregar dados, verifique sua conexção com a internet!',
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            );
        }
      },
    );
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
