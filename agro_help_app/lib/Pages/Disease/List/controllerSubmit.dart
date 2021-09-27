import 'dart:io';
import 'package:agro_help_app/ML/classifier.dart';
import 'package:agro_help_app/ML/classifier_quant.dart';
import 'package:agro_help_app/Pages/Disease/Details/deseaseDetail.dart';
import 'package:agro_help_app/povider/diseaseProvider.dart';
import 'package:agro_help_app/utils/doenca.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

part 'controllerSubmit.g.dart';

class ControllerSumition = ControllerSubmitionBase with _$ControllerSumition;

abstract class ControllerSubmitionBase with Store {
  static String modelName = 'MultLabelModel.tflite';
  static String labelName = 'assets/labels.txt';
  @observable
  late String _title = 'Loading...';
  //@observable
  //Fruit fruit = new Fruit();
  @action
  void modelSelected(int selected) {
    if (selected == 0) {
      modelName = 'ml/apple/apple.tflite';
      labelName = 'assets/ml/apple/apple.txt';
      _title = 'Maçã';
    } else if (selected == 1) {
      modelName = 'ml/corn/corn.tflite';
      labelName = 'assets/ml/corn/corn.txt';
      _title = 'Milho';
    } else if (selected == 2) {
      modelName = 'ml/grape/grape.tflite';
      labelName = 'assets/ml/grape/grape.txt';
      _title = 'Uva';
    } else if (selected == 3) {
      modelName = 'ml/tomato/tomato.tflite';
      labelName = 'assets/ml/tomato/tomato.txt';
      _title = 'Tomate';
    }
    print(modelName);
    print(labelName);
    _classifier = ClassifierQuant(fileModelName: modelName, fileLabelName: labelName);
  }

  String get title => _title;

  Classifier _classifier = ClassifierQuant(fileModelName: modelName, fileLabelName: labelName);

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
  Future getImage(BuildContext context) async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    image = File(pickedFile!.path);
    _imageWidget = Image.file(image!);

    _predict(context);
  }

  void _predict(BuildContext context) async {
    img.Image imageInput = img.decodeImage(image!.readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);

    this.category = pred;
    List<Disease> _diseases = Provider.of<DiseaseProvider>(context, listen: false).fruit.desease;
    _diseases.forEach((element) {
      if (element.name == pred.label) {
        element.score = pred.score;
        Provider.of<DiseaseProvider>(context, listen: false).changeSelectedDesease(element);
      }
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => DeseaseDetail()));
  }
}
