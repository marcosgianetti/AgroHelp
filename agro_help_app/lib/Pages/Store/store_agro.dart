import 'package:agro_help_app/Pages/Store/Store_item/store_item.dart';
import 'package:agro_help_app/Pages/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Utils _utils = new Utils();

class StoreAgro extends StatefulWidget {
  const StoreAgro({Key? key}) : super(key: key);

  @override
  _StoreAgroState createState() => _StoreAgroState();
}

class _StoreAgroState extends State<StoreAgro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Center(
          child: _utils.simpleText('Loja', fontSize: 36, fontWeight: FontWeight.bold),
        ),
        actions: [Image.asset('assets/img/logo.png')],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(4),
        childAspectRatio: 0.6,
        children: [
          _cardItem(context),
          _cardItem(context),
          _cardItem(context),
        ],
      ),
    );
  }

  Widget _cardItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => StoreIten()));
      },
      child: Card(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //IMAGEN
                Padding(
                    padding: const EdgeInsets.all(8.0), child: Image.asset('assets/img/store/shirt.png', height: 150)),
                //PREÇO
                _utils.simpleText('R\$: 100,00', fontSize: 24, fontWeight: FontWeight.w600),
                //DESCRIÇÃO
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: _utils.simpleText('Camisa Polo confortável e discreta',
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                _utils.simpleText('Tamanho: P, M, G, GG', fontSize: 16, fontWeight: FontWeight.w700),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: const EdgeInsets.all(8.0), child: _colors(Colors.black)),
                    Padding(padding: const EdgeInsets.all(8.0), child: _colors(Colors.grey.shade400)),
                    Padding(padding: const EdgeInsets.all(8.0), child: _colors(Colors.green.shade400)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
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
