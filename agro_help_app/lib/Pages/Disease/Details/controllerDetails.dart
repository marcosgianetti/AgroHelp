import 'package:agro_help_app/Pages/utils.dart';
import 'package:agro_help_app/povider/diseaseProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'controllerDetails.g.dart';

class ControllerDeails = _ControllerDetailsBase with _$ControllerDeails;

abstract class _ControllerDetailsBase with Store {
  Utils _utils = new Utils();
  @observable
  List<Widget> _images = <Widget>[];

  List<Widget> get images => _images;

  @action
  loadImages(BuildContext context, {double? height, double? width}) async {
    this._images = await _utils.manyImages(Provider.of<DiseaseProvider>(context, listen: false).url,
        width: width!, height: height!);
  }

  @action
  cleanImages() {
    this._images = <Widget>[];
  }
}
