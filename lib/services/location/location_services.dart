import 'package:huawei_location/location/hwlocation.dart';

abstract class LocationService {
  Future<HWLocation> getHWLocation();
}