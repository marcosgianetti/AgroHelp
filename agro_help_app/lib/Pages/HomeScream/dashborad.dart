import 'package:agro_help_app/Pages/SubmitImage/submitImage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Agro Help",
          style: GoogleFonts.montserrat(fontSize: 36),
        ),
        actions: [Image.asset('assets/img/logo.png')],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.greenAccent.shade700,
                    Colors.white,
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 8, 2),
                  child: Text(
                    'Bem vindo, Marcos',
                    style: GoogleFonts.montserrat(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: HexColor('#314299'),
                          width: 1,
                        ),
                      ),
                      width: 65,
                      height: 50,
                      child: Image.asset(
                        'assets/img/icons/apple.png',
                        height: 30,
                        width: 30,
                        //  fit: BoxFit.none,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitImage()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: HexColor('#314299'),
                          width: 1,
                        ),
                      ),
                      width: 65,
                      height: 50,
                      child: Image.asset(
                        'assets/img/icons/corn.png',
                        height: 30,
                        width: 30,
                        //  fit: BoxFit.none,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: HexColor('#314299'),
                          width: 1,
                        ),
                      ),
                      width: 65,
                      height: 50,
                      child: Image.asset(
                        'assets/img/icons/grape.png',
                        height: 30,
                        width: 30,
                        //  fit: BoxFit.none,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: HexColor('#314299'),
                          width: 1,
                        ),
                      ),
                      width: 65,
                      height: 50,
                      child: Image.asset(
                        'assets/img/icons/tomato.png',
                        height: 30,
                        width: 30,
                        //  fit: BoxFit.none,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height / 2.5,
                    width: width - 100,
                    color: Colors.amber.shade100,
                    child: Center(
                      child: Text('Clima'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height / 2.5,
                    width: width - 100,
                    color: Colors.amber.shade100,
                    child: Center(
                      child: Text('Noticias'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
