import 'package:custom_camera_preview/core/routes/app_routes.dart';
import 'package:custom_camera_preview/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraResult extends StatelessWidget {
  const CameraResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.find<HomeController>();
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(Routes.INITIAL);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Camera Preview"),
          automaticallyImplyLeading: false,
        ),
        body: _homeController.imageFiles.isEmpty
            ? const Center(child: Text("List is empty"))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: context.height * 0.5,
                    child: Image.file(
                      _homeController.imageFiles[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
                itemCount: _homeController.imageFiles.length,
              ),
      ),
    );
  }
}
