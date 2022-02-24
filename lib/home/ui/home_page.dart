import 'package:custom_camera_preview/core/routes/app_routes.dart';
import 'package:custom_camera_preview/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera Preview"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Take Photos"),
          IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () async {
                Get.find<HomeController>().imageFiles = [];
                Get.toNamed(Routes.CAMERA);
              }),
        ],
      )),
    );
  }
}
