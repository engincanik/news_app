abstract class PermissionServices {
  Future<bool> requestLocationPermission();
  Future<bool> hasLocationPermission();
}