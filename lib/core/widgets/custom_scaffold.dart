import 'package:custom_camera_preview/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  Widget body;
  CustomScaffold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Camera Preview", style: _customTextStyle()),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: body,
    );
  }

  TextStyle _customTextStyle() {
    return const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic);
  }
}
