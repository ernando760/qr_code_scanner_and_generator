abstract class IPermissionService {
  Future<AppPermissionStatus> request(AppTypePermission typePermission);
  Future<List<AppPermissionStatus>> requests(
      Set<AppTypePermission> typePermissions);
}

enum AppPermissionStatus {
  granted,
  denied,
  unknown;
}

enum AppTypePermission {
  storage,
  photos;
}

extension AppPermissionStatusGetter on AppPermissionStatus {
  bool get isGranted => this == AppPermissionStatus.granted;
  bool get isdenied => this == AppPermissionStatus.denied;
  bool get isUnknown => this == AppPermissionStatus.unknown;
}
