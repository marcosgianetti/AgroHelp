// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllerSubmit.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControllerSumition on ControllerSubmitionBase, Store {
  final _$imageAtom = Atom(name: 'ControllerSubmitionBase.image');

  @override
  File get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$_imageWidgetAtom = Atom(name: 'ControllerSubmitionBase._imageWidget');

  @override
  Image get _imageWidget {
    _$_imageWidgetAtom.reportRead();
    return super._imageWidget;
  }

  @override
  set _imageWidget(Image value) {
    _$_imageWidgetAtom.reportWrite(value, super._imageWidget, () {
      super._imageWidget = value;
    });
  }

  final _$categoryAtom = Atom(name: 'ControllerSubmitionBase.category');

  @override
  Category get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(Category value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  final _$getImageAsyncAction = AsyncAction('ControllerSubmitionBase.getImage');

  @override
  Future<dynamic> getImage() {
    return _$getImageAsyncAction.run(() => super.getImage());
  }

  @override
  String toString() {
    return '''
image: ${image},
category: ${category}
    ''';
  }
}
