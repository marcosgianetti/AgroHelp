import 'dart:io';
import 'package:agro_help_app/ML/classifier_quant.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import '../../ML/classifier.dart';
part 'controllerSubmit.g.dart';

class ControllerSumition = ControllerSubmitionBase with _$ControllerSumition;

abstract class ControllerSubmitionBase with Store {
  Classifier _classifier = ClassifierQuant();

  Classifier get classifier => _classifier;

  var logger = Logger();

  @observable
  File? image;
  final _picker = ImagePicker();

  @observable
  Image? _imageWidget;
  Image get imageWidget => _imageWidget!;

  img.Image? fox;

  @observable
  Category? category;

  @action
  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    image = File(pickedFile!.path);
    _imageWidget = Image.file(image!);

    _predict();
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(image!.readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);

    this.category = pred;
  }
}
