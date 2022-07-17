import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/setting/setting_tile.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionTile extends SettingTile {
  VersionTile({required String title}) : super(title: title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<PackageInfo>(
        future: _getPackageInfo(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Text('ERROR');
          } else if (!snapshot.hasData) {
            return const Text('Loading...');
          }
          final data = snapshot.data!;

          return Container(
            height: super.height,
            child: Container(
              padding: super.default_padding,
              child: Row(
                children: [
                  //SizedBox(width: super.blank),
                  const Text('버전'),
                  const Spacer(),
                  Text(data.version),
                  //SizedBox(width: super.blank),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<PackageInfo> _getPackageInfo() {
    return PackageInfo.fromPlatform();
  }
}
