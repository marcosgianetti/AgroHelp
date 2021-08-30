import 'package:agro_help_app/Pages/SubmitImage/controllerSubmit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SubmitImage extends StatelessWidget {
  final controller = ControllerSumition();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TfLite Flutter Helper', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: <Widget>[
          Observer(builder: (_) {
            return Center(
              child: controller.image == null
                  ? Text('No image selected.')
                  : Container(
                      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: controller.imageWidget,
                    ),
            );
          }),
          SizedBox(
            height: 36,
          ),
          Observer(builder: (_) {
            return Text(
              controller.category != null ? controller.category.label : '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            );
          }),
          SizedBox(
            height: 8,
          ),
          Observer(builder: (_) {
            return Text(
              controller.category != null ? 'Confidence: ${controller.category.score.toStringAsFixed(3)}' : '',
              style: TextStyle(fontSize: 16),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.getImage();
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
