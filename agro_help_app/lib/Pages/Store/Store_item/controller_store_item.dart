import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'controller_store_item.g.dart';

// This is the class used by rest of your codebase
class ControllerStoreItem = _ControllerStoreItem with _$ControllerStoreItem;

// The store-class
abstract class _ControllerStoreItem with Store {
  @observable
  String tamanhoSelecionado = '';
  @observable
  var tamanhos;
  @observable
  Color colorsSelected = Color(456);

  @action
  dispose() {
    tamanhoSelecionado = '';
    colorsSelected = Color(456);
  }
}
