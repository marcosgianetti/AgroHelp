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

class DeseaseDetail extends StatelessWidget {
  double _width = 0.0;
  double _height = 0.0;
  Fruit _fruit = new Fruit();
  Disease _disease = new Disease();
/*
  @override
  initState() {
    print('Init State');
    super.initState();
    //   _controller.checkScore(context, Provider.of<DiseaseProvider>(context, listen: false).selectedDesease.score);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.cleanImages();
  }*/

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _fruit = Provider.of<DiseaseProvider>(context, listen: false).fruit;
    _disease = Provider.of<DiseaseProvider>(context, listen: false).selectedDesease;

    _controller.loadImages(context, width: _height / 3, height: _height / 3);
    Future.delayed(Duration.zero, () async {
      _controller.checkScore(context, _disease.score * 100);
    });

    //_controller.checkScore(context, _disease.score);
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
              height: _height / 3,
              child: Observer(
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
                  _utils.simpleText('${_disease.namePT}', fontSize: 24, fontWeight: FontWeight.w500),
                  Visibility(
                    visible: _disease.score > 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _utils.simpleText(
                          'Taxa de confiabilidade: ${(_disease.score * 100).toString().split('.')[0]}%',
                          fontSize: _disease.score < 0.9 ? 24 : 18,
                          color: _disease.score < 0.9 ? Colors.red : null,
                          fontWeight: _disease.score < 0.9 ? FontWeight.w800 : FontWeight.w400),
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      height: _height / 4,
                      width: _width - 50,
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
                      height: _height / 4,
                      width: _width - 50,
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
                      height: _height / 4,
                      width: _width - 50,
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
