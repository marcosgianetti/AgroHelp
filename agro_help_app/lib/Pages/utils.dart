import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

//https://pub.dev/packages/awesome_dialog

class Utils {
  Widget simpleText(String str, {double? fontSize = 12, Color? color, FontWeight? fontWeight = FontWeight.normal}) {
    return Text(str, style: GoogleFonts.montserrat(fontSize: fontSize, fontWeight: fontWeight, color: color));
  }

  Future<void> showLoadingDialog(BuildContext context, {String text = "Please Wait...."}
      /*GlobalKey key*/) async {
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
