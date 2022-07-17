import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/setting/setting_tile.dart';

class MainTitleTile extends SettingTile {
  MainTitleTile({required String title}) : super(title: title);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Padding(
        padding: super.default_padding,
        child: Column(
          children: [
            Row(
              children: [
                //SizedBox(width: super.blank),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            //SizedBox(height: super.blank),
          ],
        ),
      ),
      alignment: Alignment.centerLeft,
    );
  }
}
