import 'package:huawei_location/permission/permission_handler.dart';
import 'package:newsapp/services/permission/permission_services.dart';

class PermissionServicesImpl implements PermissionServices {
  PermissionHandler _permissionHandler = PermissionHandler();

  @override
  Future<bool> hasLocationPermission() async {
    return _permissionHandler.hasLocationPermission();
  }

  @override
  Future<bool> requestLocationPermission() async {
    return _permissionHandler
        .requestLocationPermission();
//        .timeout(Duration(milliseconds: 2000), onTimeout: () => null);
  }
}
