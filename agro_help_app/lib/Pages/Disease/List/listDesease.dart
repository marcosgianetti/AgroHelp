import 'package:agro_help_app/Pages/Disease/Details/deseaseDetail.dart';
import 'package:agro_help_app/Pages/utils.dart';
import 'package:agro_help_app/provider/diseaseProvider.dart';
import 'package:agro_help_app/utils/doenca.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';
//https://www.youtube.com/watch?v=YA_fHCF_EYc&ab_channel=JohannesMilke
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
            /*       StreamBuilder(
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
            ),*/
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
    try {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _utils.oneImage(
                      'files/${Provider.of<DiseaseProvider>(context, listen: false).fruit.dbName}/${nomeDoenca['doenca']}/',
                      width: witdh * 0.2,
                      height: witdh * 0.2),
                ),
                Container(
                  width: witdh * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.bottomLeft,
                          child: _utils.simpleTextSelectable(
                            nomeDoenca['doencaPT'] ?? 'Dado nao definido',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.start,
                          )),
                      _catacterisitica(doenca: nomeDoenca)
                      //_utils.simpleText('A doenca x é causada por y, resultando em z', fontSize: 16)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (_) {
      return Container();
    }
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

  Widget _catacterisitica({dynamic? doenca}) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(doenca['doenca']!).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.active:
            if (snapshot.hasData) {
              try {
                final docs = snapshot.data!.docs;
                Disease disease = new Disease();
                disease.name = doenca['doenca'];
                disease.namePT = doenca['doencaPT'] ?? 'Dados não definidos';
                disease.caracteristc = docs[0].data()['caracteristica'] ?? '';
                disease.treatement = docs[0].data()['combate'] ?? '';
                disease.prevention = docs[0].data()['evitar'] ?? '';
                disease.font = docs[0].data()['fonte'] ?? '';

                Provider.of<DiseaseProvider>(context, listen: false).fruit.desease.add(disease);

                return GestureDetector(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _text('Caracteristica: ', disease.caracteristc),
                      _text('Combate: ', disease.treatement),
                      _text('Prevenção: ', disease.prevention),
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

  Widget _text(String str1, String str2) {
    return Visibility(
      visible: str2 != '',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
        child: _utils.simpleText(str1 + str2.substring(0, str2.length < 20 ? str2.length : 20) + '...', fontSize: 14),
      ),
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
