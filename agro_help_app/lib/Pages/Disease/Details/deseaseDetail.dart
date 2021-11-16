import 'package:agro_help_app/Pages/Store/store_agro.dart';
import 'package:agro_help_app/provider/diseaseProvider.dart';
import 'package:agro_help_app/utils/doenca.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'controllerDetails.dart';

Utils _utils = new Utils();
ControllerDeails _controller = ControllerDeails();

class DeseaseDetail extends StatelessWidget {
  double _height = 0.0;
  Fruit _fruit = new Fruit();
  Disease _disease = new Disease();
  Disease disease = new Disease();
  DeseaseDetail({Key? key, required this.disease}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _fruit = Provider.of<DiseaseProvider>(context, listen: false).fruit;
    if (disease.namePT == '')
      _disease = Provider.of<DiseaseProvider>(context, listen: false).selectedDesease;
    else {
      _disease = disease;
      //_disease = Provider.of<DiseaseProvider>(context, listen: false).selectedDesease;
      Future.delayed(Duration(milliseconds: 5), () async {
        Provider.of<DiseaseProvider>(context, listen: false).changeSelectedDesease(_disease);
        _controller.loadImages(context, width: _height / 3, height: _height / 3);
      });
    }

    _controller.loadImages(context, width: _height / 3, height: _height / 3);
    Future.delayed(Duration.zero, () async {
      _controller.checkScore(context, _disease.score * 100);
    });
    var brightness = MediaQuery.of(context).platformBrightness;
    bool _isDarkMode = brightness == Brightness.dark;

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
              //color: Theme.of(context).secondaryHeaderColor,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                  child: _utils.simpleTextSelectable('${_disease.namePT}',
                      color: _isDarkMode ? Colors.white : Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center)),
            ),
            Container(
              height: _height / 3,
              child: Observer(
                builder: (_) {
                  return _controller.images.length > 0
                      ? CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: _controller.images.length > 1,
                            aspectRatio: 16 / 9,
                            autoPlayInterval: Duration(seconds: 2),
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
                _card(context, 'Característica', _disease.caracteristc),
                _card(context, 'Prevenção', _disease.prevention),
                anuncio(context, openBuilder: new StoreAgro()),
                _card(context, 'Tratamento', _disease.treatement),
                _card(context, 'Fonte', _disease.font),
                SizedBox(height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget anuncio(BuildContext context, {Widget? openBuilder}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OpenContainer(
        closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        transitionDuration: Duration(milliseconds: 480),
        closedColor: Color.fromRGBO(105, 103, 88, 1),
        openBuilder: (context, _) => openBuilder!,
        closedBuilder: (context, VoidCallback openContainer) => GestureDetector(
          onTap: openContainer,
          child: Column(
            children: [
              Container(
                color: Color.fromRGBO(43, 56, 37, 1),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.store, color: Colors.white, size: 24),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                        child: _utils.simpleText('Venha já conhecer nossos produtos da Agro Help Store',
                            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                alignment: Alignment.topLeft,
                height: 80,
                child: _utils.simpleText('Camisas, chapéis, roupas para trabalho e muito mais.',
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Container(
                height: 176,
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: _controller.images.length > 1,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                  ),
                  items: _controller.images,
                ),
              ),
              SizedBox(height: 8)
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(BuildContext context, String title, String str) {
    return Visibility(
      visible: str != '',
      child: _utils.agroCard(
        context,
        title: Row(
          children: [
            _iconCard(title),
            _utils.simpleTextSelectable(title, fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ],
        ),
        body: title == 'Fonte'
            ? _fonte(str)
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: _utils.simpleTextSelectable(str, fontSize: 16))),
      ),
    );
  }

  Widget _iconCard(String title) {
    Icon icon = new Icon(Icons.check);

    if (title == 'Característica') {
      icon = Icon(MdiIcons.exclamation);
    } else if (title == 'Fonte') {
      icon = Icon(MdiIcons.book);
    } else if (title == 'Tratamento') {
      icon = Icon(Icons.sports);
    }
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: icon,
    );
  }

  Widget _fonte(String str) {
    return TextButton(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: _utils.simpleText(str, fontSize: 16, color: Colors.blue)),
      ),
      onPressed: () async {
        if (await canLaunch(str)) {
          await launch(str);
        } else {
          Fluttertoast.showToast(
            msg: "Erro ao fazer compra",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
          );
        }
      },
    );
  }
}
