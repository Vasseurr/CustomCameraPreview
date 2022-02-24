import 'dart:io';

import 'package:custom_camera_preview/home/repository/home_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeRepository _repository;
  HomeController(this._repository) : assert(_repository != null);
  final RxString _userName = "".obs;
  List<File> imageFiles = [];

  get userName => _userName.value;

  set userName(value) => _userName.value = value;
}
