import 'dart:io';

import 'package:camera/camera.dart';
import 'package:custom_camera_preview/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCameraPreview extends StatefulWidget {
  List<File> imageFiles;
  CameraController cameraController;
  CustomCameraPreview(
      {Key? key, required this.imageFiles, required this.cameraController})
      : super(key: key);

  @override
  _CustomCameraPreviewState createState() => _CustomCameraPreviewState();
}

class _CustomCameraPreviewState extends State<CustomCameraPreview> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: FractionalOffset.center,
      children: <Widget>[
        Positioned.fill(
          child: AspectRatio(
              aspectRatio: widget.cameraController.value.aspectRatio,
              child: CameraPreview(widget.cameraController)),
        ),
        Positioned(
            bottom: 5,
            child: FloatingActionButton(
              heroTag: "camera",
              backgroundColor: Colors.white,
              onPressed: () async {
                //you can give limit that's user can take how many photo
                if (widget.imageFiles.length != 10) {
                  //take a photo
                  var videoFile = await widget.cameraController.takePicture();
                  File file = File(videoFile.path);
                  //add photo into files list
                  widget.imageFiles.add(file);
                }
              },
              child: const Icon(
                Icons.camera_alt,
                color: Colors.black,
              ),
            )),
        _confirmButton(),
        _rejectButton(),
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
                    child: index >= widget.imageFiles.length
                        ? Container(color: Colors.white, width: 100)
                        : Stack(
                            children: [
                              Image.file(
                                widget.imageFiles[index],
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
                                        widget.imageFiles.removeAt(index);
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

  Positioned _rejectButton() {
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
