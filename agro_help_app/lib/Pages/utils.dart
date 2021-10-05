import 'package:agro_help_app/api/firebase_api.dart';
import 'package:agro_help_app/model/firebase_file.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

//https://pub.dev/packages/awesome_dialog

class Utils {
  Widget simpleText(String str, {double? fontSize = 12, Color? color, FontWeight? fontWeight = FontWeight.normal}) {
    return Text(
      str.replaceAll('\\\\n', '\n'),
      style: GoogleFonts.montserrat(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
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
            return Container(width: width, height: height, child: Center(child: CircularProgressIndicator()));

          default:
            if (snapshot.hasError) {
              return ClipOval(
                child: Image.network(
                  '',
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                  errorBuilder: (context, url, error) => Icon(
                    Icons.no_photography_outlined,
                    size: width,
                  ),
                ),
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

  Widget newsCart(dynamic docs) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          docs.data()['Title'] != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                  child: simpleText('${docs['Title']}', fontSize: 32, fontWeight: FontWeight.bold),
                )
              : Container(),
          docs.data()['Subtitle'] != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                  child: simpleText('${docs['Subtitle']}', fontSize: 24, fontWeight: FontWeight.w500),
                )
              : Container(),
          docs.data()['Body'] != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: simpleText('${docs['Body']}', fontSize: 16, fontWeight: FontWeight.w400),
                )
              : Container(),
        ],
      ),
    );
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

  alert(BuildContext context, {String? title, String? desc}) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      btnOkOnPress: () {
        //    Navigator.pop(context);
      },
    )..show();
  }
}
