import 'package:agro_help_app/povider/diseaseProvider.dart';
import 'package:agro_help_app/utils/doenca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../utils.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'controllerDetails.dart';

Utils _utils = new Utils();
ControllerDeails _controller = ControllerDeails();

class DeseaseDetail extends StatefulWidget {
  const DeseaseDetail({Key? key}) : super(key: key);

  @override
  _DeseaseDetailState createState() => _DeseaseDetailState();
}

class _DeseaseDetailState extends State<DeseaseDetail> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Fruit _fruit = Provider.of<DiseaseProvider>(context, listen: false).fruit;
    Disease _disease = Provider.of<DiseaseProvider>(context, listen: false).selectedDesease;

    _controller.loadImages(context, width: height / 3, height: height / 3);
    @override
    void dispose() {
      super.dispose();
      _controller.cleanImages();
    }

    return Scaffold(
      appBar: new AppBar(
        title: Center(
          child: _utils.simpleText(_fruit.name, fontSize: 36, fontWeight: FontWeight.bold),
        ),
        actions: [Image.asset('assets/img/logo.png')],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height / 3,
              child: //Container(child: _utils.onhjkaseImage(Provider.of<DiseaseProvider>(context, listen: false).url)

                  Observer(
                builder: (_) {
                  return _controller.images.length > 0
                      ? CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: _controller.images.length > 1,
                            aspectRatio: 16 / 9,
                            enlargeCenterPage: true,
                          ),
                          items: _controller.images,
                        )
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
            new Center(
              child: Column(
                children: [
                  _utils.simpleText('${_disease.name}', fontSize: 24, fontWeight: FontWeight.w500),
                  Visibility(
                    visible: _disease.score > 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _utils.simpleText(
                          'Taxa de confiabilidade: ${(_disease.score * 100).toString().split('.')[0]}%',
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      height: height / 4,
                      width: width - 50,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _utils.simpleText('Caracteristica: ', fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Center(child: _utils.simpleText(_disease.caracteristc, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      height: height / 4,
                      width: width - 50,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _utils.simpleText('Prevenção: ', fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Center(child: _utils.simpleText('Prevenção: ' + _disease.prevention, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      height: height / 4,
                      width: width - 50,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _utils.simpleText('Tratamento: ', fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _utils.simpleText('Tratamento: ' + _disease.treatement, fontSize: 16),
                          )),
                        ],
                      ),
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
