import 'package:agro_help_app/api/firebase_api.dart';
import 'package:agro_help_app/model/firebase_file.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

//https://pub.dev/packages/awesome_dialog

class Utils {
  String name() => 'Agro Help';

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

  Widget simpleTextSelectable(
    String str, {
    double? fontSize = 12,
    Color? color,
    FontWeight? fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.justify,
  }) {
    return SelectableText(
      str.replaceAll('\\\\n', '\n'),
      cursorWidth: 5,
      textAlign: textAlign,
      cursorRadius: Radius.circular(5),
      style: GoogleFonts.montserrat(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  Widget agroCard(BuildContext context, {required Widget title, required Widget body, EdgeInsets? padding}) {
    double _raduisRounded = 24.0;
    padding = padding ?? EdgeInsets.all(8.0);
    return Padding(
      padding: padding,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_raduisRounded)),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(_raduisRounded), topLeft: Radius.circular(_raduisRounded)),
                ),
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                child: title),
            body,
          ],
        ),
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
    bool _hasConnection = await checkConnectivity();
    if (!_hasConnection) {
      return <Widget>[
        Container(
          width: width,
          height: height,
          child: Icon(Icons.wifi_off, size: width),
        ),
      ];
    } else {
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
            errorBuilder: (context, url, error) => Icon(Icons.no_photography_outlined, size: width),
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
                errorBuilder: (context, url, error) => Icon(Icons.no_photography_outlined, size: width),
              ),
            );
          },
        );
        return saida;
      }
    }
  }

  Widget newsCart(BuildContext context, dynamic docs) {
    return agroCard(
      context,
      title: docs.data()['Title'] != null
          ? Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
              child: simpleTextSelectable('${docs['Title']}',
                  fontSize: 32, textAlign: TextAlign.center, color: Colors.white, fontWeight: FontWeight.w400),
            )
          : Container(),
      body: Column(
        children: [
          docs.data()['Subtitle'] != null
              ? Padding(
                  padding: const EdgeInsets.all(8),
                  child: simpleTextSelectable('${docs['Subtitle']}',
                      textAlign: TextAlign.start, fontSize: 24, fontWeight: FontWeight.w500),
                )
              : Container(),
          docs.data()['Body'] != null
              ? Padding(
                  padding: const EdgeInsets.all(8),
                  child: simpleTextSelectable('${docs['Body']}',
                      textAlign: TextAlign.start, fontSize: 16, fontWeight: FontWeight.w400),
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

  alert(BuildContext context, {String? title, String? desc, Function? btnOkOnPress}) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      btnOkOnPress: btnOkOnPress,
    )..show();
  }

  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
      // I am connected to a wifi network.
    } else {
      return false;
    }
  }
}
