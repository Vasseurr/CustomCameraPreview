import 'dart:io';

import 'package:camera/camera.dart';
import 'package:custom_camera_preview/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  final HomeController _homeController = Get.find<HomeController>();

  CameraController? controller;
  late List cameras;
  late int selectedCameraIdx;
  late String imagePath;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.isNotEmpty) {
        setState(() {
          selectedCameraIdx = 0;
        });
        _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);
    controller!.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (controller!.value.hasError) {
        print('Camera error ${controller!.value.errorDescription}');
      }
    });
    try {
      await controller!.initialize();
    } on CameraException catch (e) {
      print(e.description);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    return Stack(
      alignment: FractionalOffset.center,
      children: <Widget>[
        Positioned.fill(
          child: AspectRatio(
              aspectRatio: controller!.value.aspectRatio,
              child: CameraPreview(controller!)),
        ),
        Positioned(
            bottom: 5,
            child: FloatingActionButton(
              heroTag: "camera",
              backgroundColor: Colors.white,
              onPressed: () async {
                //you can give limit that's user can take how many photo
                if (_homeController.imageFiles.length != 10) {
                  //take a photo
                  var videoFile = await controller!.takePicture();
                  File file = File(videoFile.path);
                  //add into files list
                  _homeController.imageFiles.add(file);
                }
              },
              child: const Icon(
                Icons.camera_alt,
                color: Colors.black,
              ),
            )),
        _confirmButton(),
        _closeButton(),
        Positioned(
            bottom: 80,
            child: SizedBox(
              height: 80,
              width: context.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: Colors.white)),
                    child: index >= _homeController.imageFiles.length
                        ? Container(color: Colors.white, width: 100)
                        : Stack(
                            children: [
                              Image.file(
                                _homeController.imageFiles[index],
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              ),
                              Positioned(
                                top: 2.5,
                                right: 2.5,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _homeController.imageFiles
                                            .removeAt(index);
                                      });
                                    },
                                    child: const Icon(Icons.close,
                                        size: 12, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  );
                },
                itemCount: 10,
              ),
            )),
      ],
    );
  }

  Positioned _closeButton() {
    return Positioned(
      bottom: 5,
      left: 5,
      child: FloatingActionButton(
        heroTag: "close",
        backgroundColor: Colors.black,
        onPressed: () async {
          Get.toNamed(Routes.INITIAL);
        },
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
    );
  }

  Positioned _confirmButton() {
    return Positioned(
        bottom: 5,
        right: 5,
        child: FloatingActionButton(
          heroTag: "confirm",
          backgroundColor: Colors.black,
          onPressed: () async {
            Get.toNamed(Routes.LIST);
          },
          child: const Icon(
            Icons.check,
            color: Colors.white,
          ),
        ));
  }
}
