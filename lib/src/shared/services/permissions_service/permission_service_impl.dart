import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner_and_generator/src/shared/services/permissions_service/i_permission_service.dart';

class PermissionServiceImpl extends IPermissionService {
  final Map<AppTypePermission, Permission> _permissionMap = {
    AppTypePermission.storage: Permission.storage,
    AppTypePermission.photos: Permission.photos
  };

  @override
  Future<AppPermissionStatus> request(AppTypePermission typePermission) async {
    if (_permissionMap.containsKey(typePermission)) {
      final status = await _permissionMap[typePermission]!.request();
      return switch (status) {
        PermissionStatus.granted => AppPermissionStatus.granted,
        PermissionStatus.denied => AppPermissionStatus.denied,
        _ => AppPermissionStatus.unknown,
      };
    }
    return AppPermissionStatus.unknown;
  }

  @override
  Future<List<AppPermissionStatus>> requests(
      Set<AppTypePermission> typePermissions) async {
    final List<Future<PermissionStatus>> futures = [];
    for (var type in _permissionMap.keys) {
      if (typePermissions.contains(type)) {
        futures.add(_permissionMap[type]!.request());
      }
    }

    final result = await Future.wait(futures);

    return result
        .map((status) => switch (status) {
              PermissionStatus.granted => AppPermissionStatus.granted,
              PermissionStatus.denied => AppPermissionStatus.denied,
              _ => AppPermissionStatus.unknown
            })
        .toList();
  }
}
