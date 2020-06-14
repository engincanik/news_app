import 'package:huawei_location/location/fused_location_provider_client.dart';
import 'package:huawei_location/location/hwlocation.dart';
import 'package:huawei_location/location/location_request.dart';
import 'package:newsapp/services/location/location_services.dart';
import 'package:newsapp/services/permission/permission_services.dart';
import 'package:newsapp/services/service_locator.dart';

class LocationServicesImpl implements LocationService {
  final PermissionServices _permissionServices =
      serviceLocator<PermissionServices>();

  @override
  Future<HWLocation> getHWLocation() async {
    print("getHWLocation");
    if (await _permissionServices.hasLocationPermission()) {
      FusedLocationProviderClient locationService =
          FusedLocationProviderClient();
      LocationRequest locationRequest = LocationRequest();
      locationRequest.needAddress = true;
      final hwLocation = locationService
          .getLastLocationWithAddress(locationRequest);
//          .timeout(Duration(milliseconds: 2000), onTimeout: () => null);
      return hwLocation;
    }
  }
}
