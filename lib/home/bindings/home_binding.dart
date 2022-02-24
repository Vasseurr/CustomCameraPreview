import 'package:custom_camera_preview/home/controller/home_controller.dart';
import 'package:custom_camera_preview/home/repository/home_repository.dart';
import 'package:custom_camera_preview/home/service/home_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() {
      return HomeController(HomeRepository(HomeService(Dio())));
    });
  }
}
