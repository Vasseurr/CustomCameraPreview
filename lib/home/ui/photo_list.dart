import 'package:custom_camera_preview/core/routes/app_routes.dart';
import 'package:custom_camera_preview/core/widgets/custom_scaffold.dart';
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
      child: CustomScaffold(
        body: _homeController.imageFiles.isEmpty
            ? const Center(child: Text("List is empty"))
            : _content(context, _homeController),
      ),
    );
  }

  Column _content(BuildContext context, HomeController _homeController) {
    return Column(
      children: [
        SizedBox(height: context.height * 0.05),
        SizedBox(
            height: context.height * 0.2,
            child: Image.asset("assets/icon.png")),
        SizedBox(height: context.height * 0.05),
        _photoCards(_homeController),
      ],
    );
  }

  Expanded _photoCards(HomeController _homeController) {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              height: context.height * 0.5,
              child: Card(
                child: Image.file(
                  _homeController.imageFiles[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: _homeController.imageFiles.length,
      ),
    );
  }
}
