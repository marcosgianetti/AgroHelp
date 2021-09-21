import 'package:agro_help_app/Pages/SubmitImage/controllerSubmit.dart';
import 'package:agro_help_app/Pages/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';

Utils _utils = new Utils();

class SubmitImage extends StatelessWidget {
  late int selected = 0;
  SubmitImage({this.selected: 0});
  late int example = 10;

  final controller = ControllerSumition();
  // late String _title;
  @override
  Widget build(BuildContext context) {
    controller.modelSelected(selected);
    print(selected.toString());
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: // Observer(
              // builder: (_) {
              // return
              _utils.simpleText(controller.title, fontSize: 36),
          // },
          // ),
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
            /* ListView.builder(
                itemCount: example,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("item: " + index.toString()),
                  );
                }),*/
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
            child: Text("Enviar uma imagem"),
          ),
        ),
      ),
    );
  }

  Widget card() {
    return Text('a');
    /* Card(
      child: Row(
        children: [
          SizedBox(
              // width: 100,
              //height: 100,
              ),
          /*  Column(
            children: [
              //_utils.simpleText('Doença X', fontSize: 24),
              //   _utils.simpleText('A doenca x é causada por y, resultando em z', fontSize: 1)
            ],
          )*/
        ],
      ),
    );*/
  }
}
