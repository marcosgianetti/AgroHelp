import 'package:agro_help_app/utils/doenca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class DiseaseProvider extends ChangeNotifier {
  Fruit fruit = new Fruit();
  Disease _selectedDesease = new Disease();

  changeSelectedDesease(Disease value) {
    this._selectedDesease = value;
    notifyListeners();
  }

  String get urlImagensFruta => 'files/${this.fruit.dbName}/${this._selectedDesease.name}/';
  Disease get selectedDesease => this._selectedDesease;
}
