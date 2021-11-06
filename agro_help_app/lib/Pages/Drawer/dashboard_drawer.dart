import 'package:agro_help_app/Pages/Store/store_agro.dart';
import 'package:agro_help_app/Pages/utils.dart';
import 'package:agro_help_app/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

Utils _utils = new Utils();

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _drawer(context);
  }

  Widget _drawer(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.blue.shade400,
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Image.asset('assets/img/logo.png', width: MediaQuery.of(context).size.width / 2.5),
            _utils.simpleText(_utils.name(), fontSize: 32, fontWeight: FontWeight.bold),
            SizedBox(height: 8),
            //_user(context),
            _buttonLoginOut(context, icon: Icon(Icons.dashboard), txt: 'Tela inicial', function: () {
              debugPrint('Dashboard');
              Navigator.pop(context);
            }),
            _buttonLoginOut(context, icon: Icon(Icons.store), txt: 'Loja', function: () {
              debugPrint('Store');
              Navigator.push(context, MaterialPageRoute(builder: (context) => StoreAgro()));
            }),
            _buttonLoginOut(context,
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                ),
                txt: 'Logout Goole',
                function: () => Provider.of<GoogleSignInProvider>(context, listen: false).googleLogout()),
          ],
        ),
      ),
    );
  }

  Widget _buttonLoginOut(BuildContext context,
      {@required Widget? icon, @required String? txt, @required VoidCallback? function}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.bottomCenter,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            alignment: Alignment.centerLeft,
            minimumSize: Size(MediaQuery.of(context).size.width - 80, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0))),
        onPressed: function!,
        icon: icon!,
        label: _utils.simpleText(txt!, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _user(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.verified_user_sharp),
        _utils.simpleText(Provider.of<GoogleSignInProvider>(context, listen: false).user.displayName!)
      ],
    );
  }
}
