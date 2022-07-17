import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/setting/setting_tile.dart';

class SubTextTile extends SettingTile {
  SubTextTile({required String title}) : super(title: title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: super.default_padding,
          child: Row(
            children: [
              //SizedBox(width: super.blank),
              Text(
                title,
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
        ),
        //SizedBox(height: super.blank / 2),
      ],
    );
  }
}
