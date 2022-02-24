import 'package:custom_camera_preview/home/service/base/home_service_base.dart';
import 'package:custom_camera_preview/home/service/home_service.dart';

class HomeRepository with HomeServiceBase {
  final HomeService _homeService;

  HomeRepository(this._homeService) : assert(_homeService != null);
}
