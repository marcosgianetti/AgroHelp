import 'package:agro_help_app/Pages/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

Utils _utils = new Utils();

class StoreIten extends StatefulWidget {
  const StoreIten({Key? key}) : super(key: key);

  @override
  _StoreItenState createState() => _StoreItenState();
}

class _StoreItenState extends State<StoreIten> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Center(child: _utils.simpleText('Loja', fontSize: 36, fontWeight: FontWeight.bold)),
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
              Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                  child: Image.asset('assets/img/store/shirt.png', fit: BoxFit.scaleDown)),
              //PREÇO & avaliação
              Row(
                children: [
                  _utils.simpleTextSelectable('R\$: 100,00', fontSize: 24, fontWeight: FontWeight.w600),
                  Spacer(),
                  _stars()
                ],
              ),
              //DESCRIÇÃO
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: _utils.simpleTextSelectable('Camisa Polo confortável e discreta',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: const EdgeInsets.all(8.0), child: _colors(Colors.black)),
                  Padding(padding: const EdgeInsets.all(8.0), child: _colors(Colors.grey.shade400)),
                  Padding(padding: const EdgeInsets.all(8.0), child: _colors(Colors.green.shade400)),
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
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
