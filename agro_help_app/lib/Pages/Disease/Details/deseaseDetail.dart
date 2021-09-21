import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../utils.dart';

Utils _utils = new Utils();

class DeseaseDetail extends StatelessWidget {
  const DeseaseDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: new AppBar(
        title: Center(
          child: _utils.simpleText('Doença', fontSize: 36),
        ),
        actions: [Image.asset('assets/img/logo.png')],
      ),
      body: ListWheelScrollView(
        itemExtent: 90,
        diameterRatio: 1,
        children: [
          Card(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Center(child: _utils.simpleText('foto', fontSize: 20)),
            ),
          ),
          Card(
            child: SizedBox(
              height: 400,
              width: 400,
              child: Center(child: _utils.simpleText('foto', fontSize: 20)),
            ),
          ),
          Card(
            child: SizedBox(
              height: 400,
              width: 400,
              child: Center(child: _utils.simpleText('foto', fontSize: 20)),
            ),
          ),
          Card(
            child: SizedBox(
              height: 400,
              width: 400,
              child: Center(child: _utils.simpleText('foto', fontSize: 20)),
            ),
          ),
          Card(
            child: SizedBox(
              height: 400,
              width: 400,
              child: Center(child: _utils.simpleText('foto', fontSize: 20)),
            ),
          ),
        ],
      ),
      /* SingleChildScrollView(
        child: new Center(
          child: Column(
            children: [
              Container(
                child: _utils.simpleText('Nome da doenca', fontSize: 32),
              ),
         
              Card(
                child: SizedBox(
                  height: height / 4,
                  width: width - 50,
                  child: Center(child: _utils.simpleText('Carcteristica', fontSize: 20)),
                ),
              ),
              Card(
                child: SizedBox(
                  height: height / 4,
                  width: width - 50,
                  child: Center(child: _utils.simpleText('Como tratar', fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),*/
    );
  }
}
