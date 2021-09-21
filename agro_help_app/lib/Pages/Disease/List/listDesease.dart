import 'package:agro_help_app/Pages/Disease/Details/deseaseDetail.dart';
import 'package:agro_help_app/Pages/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';

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
          child: _utils.simpleText(controller.title, fontSize: 36),
        ),
        actions: [Image.asset('assets/img/logo.png')],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Observer(builder: (_) {
              return Center(
                child: controller.image == null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'No image selected.',
                          style: GoogleFonts.montserrat(fontSize: 18),
                        ),
                      )
                    : Container(
                        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: controller.imageWidget,
                      ),
              );
            }),
            SizedBox(
              height: 36,
            ),
            Observer(builder: (_) {
              return Text(
                controller.category != null ? controller.category!.label : '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              );
            }),
            SizedBox(
              height: 8,
            ),
            listdDeseas(),
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
            Observer(builder: (_) {
              return Text(
                controller.category != null ? 'Confidence: ${controller.category!.score.toStringAsFixed(3)}' : '',
                style: TextStyle(fontSize: 16),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
        child: Tooltip(
          message: "Enviar imagem",
          child: ElevatedButton(
            onPressed: () {
              controller.getImage();
            },
            child: _utils.simpleText("Enviar uma imagem", color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _doencaCard(BuildContext context, {nomeDoenca}) {
    return GestureDetector(
      child: Card(
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
                    height: witdh * 0.2,
                  ),
                ),
              ),
              Container(
                width: witdh * 0.7,
                child: Column(
                  children: [
                    Container(alignment: Alignment.bottomLeft, child: _utils.simpleText(nomeDoenca, fontSize: 18)),
                    _utils.simpleText('A doenca x é causada por y, resultando em z', fontSize: 16)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DeseaseDetail()));
      },
    );
  }

  Widget listdDeseas() {
    Map<int, String> plantsList = {0: 'Apple', 1: 'Corn', 2: 'Grape', 3: 'Tomato'};

    try {
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection(plantsList[selected]!).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text('Error ' + snapshot.error.toString());
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Verifique sua conecxão com a internet');

            case ConnectionState.waiting:
              return LinearProgressIndicator();

            case ConnectionState.active:
              if (snapshot.hasData) {
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: docs.length,
                  itemBuilder: (_, i) {
                    return _doencaCard(context, nomeDoenca: docs[i]['doenca']);
                    /*   ListTile(
                      title: Text(docs[i]['doenca']),
                    );*/
                  },
                );
              } else {
                return Text('Algo deu errado, tente mais tarde :(');
              }
            /*  case ConnectionState.done:
              if (snapshot.hasData) {
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: docs.length,
                  itemBuilder: (_, i) {
                    return ListTile(
                      title: Text(docs[i]['doenca']),
                    );
                  },
                );
              } else {
                return Text('Algo deu errado, tente mais tarde :(');
              }*/

            default:
              return Text('Algo deu errado, tente mais tarde :(');
          }
        },
      );
    } catch (e) {
      return Text('Algo deu errado, tente mais tarde :(');
    }
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
