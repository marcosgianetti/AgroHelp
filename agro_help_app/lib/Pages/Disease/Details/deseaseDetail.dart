import 'package:agro_help_app/povider/diseaseProvider.dart';
import 'package:agro_help_app/utils/doenca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../utils.dart';
import 'package:carousel_slider/carousel_slider.dart';

Utils _utils = new Utils();

class DeseaseDetail extends StatelessWidget {
  const DeseaseDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Fruit _fruit = Provider.of<DiseaseProvider>(context, listen: false).fruit;
    Disease _disease = Provider.of<DiseaseProvider>(context, listen: false).selectedDesease;
    return Scaffold(
      appBar: new AppBar(
        title: Center(
          child: _utils.simpleText(_fruit.name, fontSize: 36),
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
                    child: _utils.simpleText(_disease.name, fontSize: 18),
                  ),
                  Card(
                    child: SizedBox(
                      height: height / 4,
                      width: width - 50,
                      child: Center(child: _utils.simpleText(_disease.caracteristc, fontSize: 20)),
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      height: height / 4,
                      width: width - 50,
                      child: Center(child: _utils.simpleText(_disease.prevention, fontSize: 20)),
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      height: height / 4,
                      width: width - 50,
                      child: Center(child: _utils.simpleText(_disease.treatement, fontSize: 20)),
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
