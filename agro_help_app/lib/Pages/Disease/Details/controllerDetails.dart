import 'package:agro_help_app/Pages/utils.dart';
import 'package:agro_help_app/provider/diseaseProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'controllerDetails.g.dart';

class ControllerDeails = _ControllerDetailsBase with _$ControllerDeails;

abstract class _ControllerDetailsBase with Store {
  Utils _utils = new Utils();
  @observable
  List<Widget> _images = <Widget>[];
  @observable
  bool _alerted = false;
  List<Widget> get images => _images;

  @action
  loadImages(BuildContext context, {double? height, double? width}) async {
    this._images = await _utils.manyImages(Provider.of<DiseaseProvider>(context, listen: false).urlImagensFruta,
        width: width!, height: height!);
  }

  @action
  dispose() {
    this._images = <Widget>[];
    _alerted = false;
  }

  checkScore(BuildContext context, double score) {
    if (score == 0)
      return;
    else if (score < 95 && !_alerted)
      _utils.alert(context,
          title: 'ALERTA\nResultado não preciso: ${score.toStringAsFixed(2)}%',
          desc:
              'Para a foto enviada, houve uma previsão de apenas: ${score.toStringAsFixed(2)}%.\nRecomendamos sempre realizar uma consulta extra com um profissional especializado.',
          btnOkOnPress: () {
        _alerted = true;
      });
  }
}
