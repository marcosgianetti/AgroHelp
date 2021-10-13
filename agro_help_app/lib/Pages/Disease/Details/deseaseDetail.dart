import 'package:agro_help_app/provider/diseaseProvider.dart';
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _utils.simpleTextSelectable('${_disease.namePT}',
                      fontSize: 24, fontWeight: FontWeight.w500, textAlign: TextAlign.center),
                ),
                Visibility(
                  visible: _disease.score > 0.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _utils.simpleText(
                        'Taxa de confiabilidade: ${(_disease.score * 100).toString().split('.')[0]}%',
                        fontSize: 24,
                        color: _disease.score < 0.9 ? Colors.red : null,
                        fontWeight: _disease.score < 0.9 ? FontWeight.w800 : FontWeight.w400),
                  ),
                ),
                _card('Caracteristica', _disease.caracteristc),
                _card('Prevenção', _disease.prevention),
                _card('Tratamento', _disease.treatement),
                _card('Fonte', _disease.font),
                SizedBox(height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(String title, String str) {
    return Visibility(
      visible: str != '',
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _utils.simpleTextSelectable(title,
                    fontSize: 20, textAlign: TextAlign.center, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: _utils.simpleTextSelectable(str, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
