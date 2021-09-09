import 'package:flutter/cupertino.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'classifier.dart';

class ClassifierQuant extends Classifier {
  String fileLabelName;
  String fileModelName;
  ClassifierQuant({int numThreads: 1, required this.fileModelName, required this.fileLabelName});

  @override
  String get modelName => fileModelName;

  @override
  String get labelsFileName => fileLabelName;

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(0, 1);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 255);
}
