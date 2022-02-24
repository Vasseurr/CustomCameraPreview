import 'package:custom_camera_preview/home/bindings/home_binding.dart';
import 'package:custom_camera_preview/home/ui/camera.dart';
import 'package:custom_camera_preview/home/ui/camera_result.dart';
import 'package:custom_camera_preview/home/ui/home_page.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.INITIAL,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(name: Routes.CAMERA, page: () => Camera(), binding: HomeBinding()),
    GetPage(
        name: Routes.LIST,
        page: () => const CameraResult(),
        binding: HomeBinding()),
  ];
}
