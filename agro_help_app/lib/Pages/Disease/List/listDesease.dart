import 'package:agro_help_app/Pages/Disease/Details/deseaseDetail.dart';
import 'package:agro_help_app/Pages/utils.dart';
import 'package:agro_help_app/provider/diseaseProvider.dart';
import 'package:agro_help_app/utils/doenca.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';
//https://www.youtube.com/watch?v=YA_fHCF_EYc&ab_channel=JohannesMilke
import 'controllerSubmit.dart';

Utils _utils = new Utils();

class SubmitImage extends StatelessWidget {
  final int selected;
  SubmitImage({required this.selected});
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
            _listdDeseas(context),
            SizedBox(height: 32),
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
                _utils.simpleText("Classificar por imagem", color: Colors.white, fontSize: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadData(BuildContext context, {dynamic doenca}) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(doenca['doenca']!).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(
              height: 80,
              child: Card(
                child: Center(
                  child: Container(
                      height: 8, padding: const EdgeInsets.fromLTRB(16, 8, 16, 8), child: CircularProgressIndicator()),
                ),
              ),
            );
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

                return _cardDoenca(context, disease);
              } catch (e) {
                return _erorrInternet();
              }
            }
            return _erorrInternet();
          default:
            return _erorrInternet();
        }
      },
    );
  }

  Widget _cardDoenca(BuildContext context, Disease disease) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DeseaseDetail(disease: disease)));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 2),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _utils.oneImage(
                      'files/${Provider.of<DiseaseProvider>(context, listen: false).fruit.dbName}/${disease.name}/',
                      width: witdh * 0.2,
                      height: witdh * 0.2),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: witdh * 0.75,
                        decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(24)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: _utils.simpleText(
                          disease.namePT,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          //textAlign: TextAlign.start,
                        ),
                      ),
                      _text('Caracteristica: ', disease.caracteristc),
                      _text('Combate: ', disease.treatement),
                      _text('Prevenção: ', disease.prevention),
                      SizedBox(height: 24)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _erorrInternet() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: _utils.simpleText('Erro ao carregar dados, verifique sua conexção com a internet!',
          fontSize: 18, fontWeight: FontWeight.w400),
    );
  }

  Widget _listdDeseas(BuildContext context) {
    try {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(Provider.of<DiseaseProvider>(context, listen: false).fruit.dbName)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) return _utils.simpleText('Error ' + snapshot.error.toString());

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return _utils.simpleText('Verifique sua conecxão com a internet');

            case ConnectionState.waiting:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
                  child: CircularProgressIndicator(),
                ),
              );

            case ConnectionState.active:
              if (snapshot.hasData) {
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: docs.length,
                  itemBuilder: (_, i) {
                    return _loadData(context, doenca: docs[i]);
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

  Widget _text(String str1, String str2) {
    var e = str2.split(' ');
    String str3 = '';
    if (e.length > 8) {
      e.removeRange(8, e.length);
      str2 = '';
      e.forEach((element) {
        str2 += '$element ';
      });
      str2 += '...';
    }

    return Visibility(
      visible: str2 != '',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
        child: Container(child: _utils.simpleText(str1 + str2, fontSize: 14)),
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
