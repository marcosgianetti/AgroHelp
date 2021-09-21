import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../utils.dart';
import 'package:carousel_slider/carousel_slider.dart';

Utils _utils = new Utils();

class DeseaseDetail extends StatelessWidget {
  const DeseaseDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: new AppBar(
        title: Center(
          child: _utils.simpleText('Nome Fruta', fontSize: 36),
        ),
        actions: [Image.asset('assets/img/logo.png')],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height / 3,
              child: Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                  items: [
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
                    Card(
                      child: SizedBox(
                        height: 400,
                        width: 400,
                        child: Center(child: _utils.simpleText('foto', fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new Center(
              child: Column(
                children: [
                  Container(
                    child: _utils.simpleText('Nome da doenca', fontSize: 18),
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
                      child: Center(child: _utils.simpleText('Motivos', fontSize: 20)),
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
          ],
        ),
      ),
    );
  }
}
