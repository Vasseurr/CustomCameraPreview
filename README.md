# Custom Camera Preview
A component has developed with Flutter

## Purpose

Instead of taking photos of a product and taking them one by one when users need to upload anywhere, they can use custom camera preview to take their photos on the same screen, see them as a list and remove them from the list if they want.

## Instruction

<h4> The Camera Preview as the photo </h4>
<img src="https://user-images.githubusercontent.com/67058617/155558382-7808ba98-e020-46f7-9215-afbee122960c.png" height="500">
<h4> Users can take photos via camera button and save in photo list as below </h4>
<img src="https://user-images.githubusercontent.com/67058617/155558406-673e9075-28b7-48f0-a92f-288ef8233b31.png" height="500">
<h4>If the user would like to delete a photo from the list, the user should use 'delete' button over the image. We deleted dog photo (third photo) from the list (You can compare previous screenshot with photo below)</h4>
<img src="https://user-images.githubusercontent.com/67058617/155558430-8e5bb4dd-b362-4c94-822e-afdc491c452b.png" height="500">

## Camera Implementation
https://pub.dev/packages/camera

You need import 'package:camera/camera.dart' in the camera preview page. Also, you should initialize your camera controller in initState
```
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
```

## Usage

If the camera controller is null or uninitialized, return a loading indicator. If not, return custom camera preview with parameters that you must given a empty list with the type of File and a camera controller
```
if (controller == null || !controller!.value.isInitialized) {
   return const Center(
     child: CircularProgressIndicator(
       color: Colors.red,
     ));
   }
   return CustomCameraPreview(
     imageFiles: _homeController.imageFiles,
     cameraController: controller!,
);
```

## Demo

https://user-images.githubusercontent.com/67058617/155554501-dcaac7cb-1797-4648-a571-57206bb131bb.mp4

