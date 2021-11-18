import 'package:agro_help_app/Pages/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

Utils _utils = new Utils();

class StoreIten extends StatelessWidget {
  final title;
  final img;
  final price;
  final tamanho;
  final desc;
  final List<Color>? colors;

  const StoreIten({
    Key? key,
    this.title,
    this.img,
    this.price,
    this.tamanho,
    this.desc,
    this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Center(child: _utils.simpleText(title, fontSize: 28, fontWeight: FontWeight.bold)),
        actions: [Image.asset('assets/img/logo.png')],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //FOTO
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height / 3,
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                      child: Image.asset(img, fit: BoxFit.scaleDown)),
                ],
              ),
              //PREÇO & avaliação
              Row(
                children: [
                  _utils.simpleTextSelectable(price, fontSize: 24, fontWeight: FontWeight.w600),
                  Spacer(),
                  _stars()
                ],
              ),
              //DESCRIÇÃO
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: _utils.simpleTextSelectable(desc,
                    fontSize: 16, fontWeight: FontWeight.w600, textAlign: TextAlign.start),
              ),
              //TAMANHO
              Row(
                children: [
                  _utils.simpleTextSelectable('Tamanho: ', fontSize: 16, fontWeight: FontWeight.w700),
                  _size()
                ],
              ),
              //CORES
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: ListView.builder(
                        itemCount: colors!.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Padding(padding: const EdgeInsets.fromLTRB(8, 4, 8, 0), child: _colors(colors![i]));
                        }),
                  ),
                ],
              ),
              //CEP
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'CEP',
                    hintText: 'CEP',
                    helperText: 'Informe seu CEP para calcular o frete',
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 4.0), borderRadius: BorderRadius.circular(24)),
                    prefixIcon: Icon(Icons.home),
                  ),
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                ),
              ),
              //COMENTARIOS
              _avaliacao(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
        child: ElevatedButton(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.monetization_on),
              ),
              _utils.simpleText('Comprar', fontSize: 24, fontWeight: FontWeight.bold)
            ],
          ),
          onPressed: () async {
            const url = 'https://www.mercadolivre.com.br/';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              Fluttertoast.showToast(
                msg: "Erro ao fazer compra",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
              );
            }
          },
        ),
      ),
    );
  }

  Widget _avaliacao() {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _utils.simpleText('5.0', fontSize: 24, fontWeight: FontWeight.bold),
            ),
            _stars(),
            _comentarios()
          ],
        ),
      ),
    );
  }

  Widget _comentarios() {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: _utils.simpleText('Marcos C.G', fontSize: 16, fontWeight: FontWeight.bold),
          subtitle: _utils.simpleTextSelectable(
              'Camisa muito boa, ótima qualidade, acabamento, sendo confortável, discreta e perferita para sair',
              fontSize: 14),
        ),
      ],
    );
  }

  Widget _size() {
    return Wrap(
      spacing: 8.0,
      children: [
        ElevatedButton(onPressed: null, child: _utils.simpleText('P', fontWeight: FontWeight.bold)),
        ElevatedButton(onPressed: null, child: _utils.simpleText('M', fontWeight: FontWeight.bold)),
        ElevatedButton(onPressed: () {}, child: _utils.simpleText('G', fontWeight: FontWeight.bold)),
        ElevatedButton(onPressed: null, child: _utils.simpleText('GG', fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _stars() {
    return RatingBar.builder(
      initialRating: 5,
      itemSize: 32,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }

  Widget _colors(Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
