import 'package:package_info_plus/package_info_plus.dart';

class PackageModel {
  String appName;
  String packageName;
  String version;
  String buildNumber;
  String buildSignature;
  String installerStore;

  PackageModel({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
    required this.buildSignature,
    required this.installerStore,
  });

  factory PackageModel.fromPackageInfo(PackageInfo packageInfo) {
    return PackageModel(
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      buildSignature: 'Unknown', // Add your logic to obtain build signature
      installerStore: 'Unknown', // Add your logic to obtain installer store
    );
  }
}
