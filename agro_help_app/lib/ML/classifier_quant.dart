import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'classifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassifierQuant extends Classifier {
  //SharedPreferences prefs = await SharedPreferences.getInstance();

  ClassifierQuant({int numThreads: 1});

  @override
  String get modelName => 'MultLabelModel.tflite';

  @override
  String get labelsFileName => 'assets/labels.txt';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(0, 1);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 255);
}
