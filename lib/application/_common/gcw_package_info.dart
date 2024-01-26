import 'package:package_info_plus/package_info_plus.dart';

class GCWPackageInfo {
  late final PackageInfo? _info;

  PackageInfo get info {
    assert(_info != null);
    return _info!;
  }

  Future<void> init() async {
    _info = await PackageInfo.fromPlatform();
  }
}