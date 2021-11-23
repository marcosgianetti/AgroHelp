// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_store_item.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControllerStoreItem on _ControllerStoreItem, Store {
  final _$tamanhoSelecionadoAtom =
      Atom(name: '_ControllerStoreItem.tamanhoSelecionado');

  @override
  String get tamanhoSelecionado {
    _$tamanhoSelecionadoAtom.reportRead();
    return super.tamanhoSelecionado;
  }

  @override
  set tamanhoSelecionado(String value) {
    _$tamanhoSelecionadoAtom.reportWrite(value, super.tamanhoSelecionado, () {
      super.tamanhoSelecionado = value;
    });
  }

  final _$tamanhosAtom = Atom(name: '_ControllerStoreItem.tamanhos');

  @override
  dynamic get tamanhos {
    _$tamanhosAtom.reportRead();
    return super.tamanhos;
  }

  @override
  set tamanhos(dynamic value) {
    _$tamanhosAtom.reportWrite(value, super.tamanhos, () {
      super.tamanhos = value;
    });
  }

  final _$colorsSelectedAtom =
      Atom(name: '_ControllerStoreItem.colorsSelected');

  @override
  Color get colorsSelected {
    _$colorsSelectedAtom.reportRead();
    return super.colorsSelected;
  }

  @override
  set colorsSelected(Color value) {
    _$colorsSelectedAtom.reportWrite(value, super.colorsSelected, () {
      super.colorsSelected = value;
    });
  }

  final _$_ControllerStoreItemActionController =
      ActionController(name: '_ControllerStoreItem');

  @override
  dynamic dispose() {
    final _$actionInfo = _$_ControllerStoreItemActionController.startAction(
        name: '_ControllerStoreItem.dispose');
    try {
      return super.dispose();
    } finally {
      _$_ControllerStoreItemActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tamanhoSelecionado: ${tamanhoSelecionado},
tamanhos: ${tamanhos},
colorsSelected: ${colorsSelected}
    ''';
  }
}
