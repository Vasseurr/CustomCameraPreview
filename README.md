# Custom Camera Preview

## Purpose

Instead of taking photos of a product and taking them one by one when users need to upload anywhere, they can use custom camera preview to take their photos on the same screen, see them as a list and remove them from the list if they want.

<h4> The Camera Preview as in the photo </h4>
<img src="https://user-images.githubusercontent.com/67058617/155558382-7808ba98-e020-46f7-9215-afbee122960c.png" height="500">
<h4> Users can take photos via camera button and save in photo list as below </h4>
<img src="https://user-images.githubusercontent.com/67058617/155558406-673e9075-28b7-48f0-a92f-288ef8233b31.png" height="500">
<h4>If the user would like to delete a photo from the list, the user should use 'delete' button over the image. We deleted dog photo (third photo) from the list (You can compare previous screenshot with photo below)</h4>
<img src="https://user-images.githubusercontent.com/67058617/155558430-8e5bb4dd-b362-4c94-822e-afdc491c452b.png" height="500">

## How to use?

First, we create a camera preview for the given camera controller.
```
Positioned.fill(
  child: AspectRatio(
    aspectRatio: controller!.value.aspectRatio,
    child: CameraPreview(controller!)),
),
```
Then, we declare buttons that includes rejected, take a photo, and confirm.
```
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
        //add photo into files list
        _homeController.imageFiles.add(file);
      }
    },
    child: const Icon(
      Icons.camera_alt,
      color: Colors.black,
    ),
  )),
  _confirmButton(),
  _rejectButton(),
),
```
You can take a photo via controller.takePicture() thanks to camera package
The last part is showing list thats include photos taken by users
```
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

```
You can show all images via Image.file() in any page
```
child: Card(
  child: Image.file(
     _homeController.imageFiles[index],
     fit: BoxFit.cover,
  ),
),
```

## Demo

https://user-images.githubusercontent.com/67058617/155554501-dcaac7cb-1797-4648-a571-57206bb131bb.mp4

