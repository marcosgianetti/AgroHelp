// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllerDetails.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControllerDeails on _ControllerDetailsBase, Store {
  final _$_imagesAtom = Atom(name: '_ControllerDetailsBase._images');

  @override
  List<Widget> get _images {
    _$_imagesAtom.reportRead();
    return super._images;
  }

  @override
  set _images(List<Widget> value) {
    _$_imagesAtom.reportWrite(value, super._images, () {
      super._images = value;
    });
  }

  final _$_alertedAtom = Atom(name: '_ControllerDetailsBase._alerted');

  @override
  bool get _alerted {
    _$_alertedAtom.reportRead();
    return super._alerted;
  }

  @override
  set _alerted(bool value) {
    _$_alertedAtom.reportWrite(value, super._alerted, () {
      super._alerted = value;
    });
  }

  final _$loadImagesAsyncAction =
      AsyncAction('_ControllerDetailsBase.loadImages');

  @override
  Future loadImages(BuildContext context, {double? height, double? width}) {
    return _$loadImagesAsyncAction
        .run(() => super.loadImages(context, height: height, width: width));
  }

  final _$_ControllerDetailsBaseActionController =
      ActionController(name: '_ControllerDetailsBase');

  @override
  dynamic dispose() {
    final _$actionInfo = _$_ControllerDetailsBaseActionController.startAction(
        name: '_ControllerDetailsBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_ControllerDetailsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
