import 'package:agro_help_app/Pages/Store/Store_item/store_item.dart';
import 'package:agro_help_app/Pages/utils.dart';
import 'package:animations/animations.dart';
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
      body: GridView.extent(
        maxCrossAxisExtent: 300,
        childAspectRatio: 0.45,
        children: [
          _cardItem(
            context,
            title: 'Camisa Polo',
            img: 'assets/img/store/shirt.png',
            price: 'R\$: 100,00',
            desc: 'Camisa Polo confortável e discreta',
            tamanho: 'Tamanho: P, M, G, GG',
            colors: [Colors.black, Colors.grey.shade400, Colors.white],
          ),
          _cardItem(
            context,
            title: 'Chapéu Agro Help',
            img: 'assets/img/store/chapeu.png',
            price: 'R\$: 45 ,00',
            desc: 'Chapéu de palha confortável',
            tamanho: 'Tamanho: M, G',
            colors: [Colors.brown.shade100],
          ),
          _cardItem(
            context,
            title: 'Roupa de campo',
            img: 'assets/img/store/roupa.png',
            price: 'R\$: 65,00',
            desc: 'Conjunto  calça e camisa manga çonga uniforme trabalho',
            tamanho: 'Tamanho: M, G, GG',
            colors: [Colors.grey.shade400, Colors.white],
          ),
        ],
      ),
    );
  }

  Widget _cardItem(
    BuildContext context, {
    String? title,
    String? img,
    String? price,
    String? tamanho,
    String? desc,
    List<Color>? colors,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OpenContainer(
        closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        transitionDuration: Duration(milliseconds: 560),
        closedColor: Theme.of(context).cardColor,
        closedBuilder: (BuildContext context, VoidCallback openContainer) => GestureDetector(
          onTap: openContainer,
          child: _utils.agroCard(
            context,
            padding: EdgeInsets.all(0),
            title: _utils.simpleText(title!, fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //IMAGEN
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                        child: Image.asset(img!, width: (MediaQuery.of(context).size.width * 0.8) / 2, height: 180)),
                  ],
                ),
                //PREÇO
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                  child: _utils.simpleText(price!, fontSize: 20, fontWeight: FontWeight.w600),
                ),
                //DESCRIÇÃO
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                  child: _utils.simpleText(desc!, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                  child: _utils.simpleText(tamanho!, fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width * 0.9) / 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        //width: 300,
                        height: 24,
                        child: ListView.builder(
                            itemCount: colors!.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return Padding(padding: const EdgeInsets.fromLTRB(8, 4, 8, 0), child: _colors(colors[i]));
                            }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        openBuilder: (BuildContext context, _) {
          return StoreIten(tamanho: tamanho, title: title, img: img, price: price, desc: desc, colors: colors);
        },
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
