import 'package:agro_help_app/api/firebase_api.dart';
import 'package:agro_help_app/model/firebase_file.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

//https://pub.dev/packages/awesome_dialog

class Utils {
  Widget simpleText(String str, {double? fontSize = 12, Color? color, FontWeight? fontWeight = FontWeight.normal}) {
    return Text(str, style: GoogleFonts.montserrat(fontSize: fontSize, fontWeight: fontWeight, color: color));
  }

  Future<void> showLoadingDialog(BuildContext context, {String text = "Please Wait...."}) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
                //key: key,
                backgroundColor: Colors.black54,
                children: <Widget>[
                  Center(
                    child: Column(children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        text,
                        style: TextStyle(color: Colors.blueAccent),
                      )
                    ]),
                  )
                ]),
          );
        });
  }

  Widget oneImage(String file, {double width = 52, double height = 52}) {
    late Future<List<FirebaseFile>> futureFiles = FirebaseApi.listAll(file);

    return FutureBuilder<List<FirebaseFile>>(
      future: futureFiles,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());

          default:
            if (snapshot.hasError) {
              return Center(
                child: simpleText('Error to load image'),
              );
            }
            final files = snapshot.data!;

            return ClipOval(
              child: Image.network(
                files.length > 0 ? files[0].url : '',
                width: width,
                height: height,
                fit: BoxFit.cover,
                errorBuilder: (context, url, error) => Icon(
                  Icons.no_photography_outlined,
                  size: width,
                ),
              ),
            );
          /*
            return ListView.builder(
              itemCount: files.length,
              shrinkWrap: true, ///////////////////////Use This Line

              itemBuilder: (context, index) {
                final file = files[index];
                return Image.network(
                  file.url,
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                );
              },
            );*/
        }
      },
    );
  }

  Future<List<Widget>> manyImages(String file, {double width = 52, double height = 52}) async {
    late Future<List<FirebaseFile>> futureFiles = FirebaseApi.listAll(file);
    print('url: ' + file);
    final url = await futureFiles;
    if (url.isEmpty) {
      return <Widget>[
        Image.network(
          '',
          width: width,
          height: height,
          fit: BoxFit.cover,
          errorBuilder: (context, url, error) => Icon(
            Icons.no_photography_outlined,
            size: width,
          ),
        ),
      ];
    } else {
      List<Widget> saida = <Widget>[];
      url.forEach(
        (element) {
          saida.add(
            Image.network(
              element.url,
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: (context, url, error) => Icon(
                Icons.no_photography_sharp,
                size: width,
              ),
            ),
          );
        },
      );
      return saida;
    }
  }

  error(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Dialog Title',
      desc: 'Dialog description here.............',
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    )..show();
  }
}
