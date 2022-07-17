import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/setting/setting_tile.dart';
import 'package:p_cube_plus_application/providers/setting_provider.dart';
import 'package:provider/provider.dart';

class SwitchTile extends SettingTile {
  final type;
  SwitchTile({required String title, required SettingType this.type})
      : super(title: title);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<SettingProvider>(context);
    themeProvider.changeState(type);
    bool _value = themeProvider.isOn;
    print(_value);
    return Container(
      height: super.height,
      child: InkWell(
        onTap: () {
          themeProvider.changeState(type);
          _value = !_value;
          themeProvider.toggle(_value);
        },
        child: Container(
          //color: Colors.white70, //배경색
          padding: super.default_padding,
          child: Row(
            children: [
              //SizedBox(width: super.blank),
              Text(super.title),
              const Spacer(),
              Transform.scale(
                scale: 0.7,
                child: SizedBox(
                  width: 40,
                  // Switch.adaptive
                  // CupertinoSwitch
                  // Switch
                  child: CupertinoSwitch(
                    activeColor: Colors.red,
                    //activeTrackColor: Colors.red.withOpacity(0.4),
                    //inactiveThumbColor: Colors.blue,
                    //inactiveTrackColor: Colors.blue.withOpacity(0.4),
                    //splashRadius: 30, // 클릭 시 색 크기
                    value: _value,
                    onChanged: (value) {
                      themeProvider.changeState(type);
                      _value = value;
                      themeProvider.toggle(_value);
                    },
                  ),
                ),
              ),
              //SizedBox(width: super.blank / 2),
            ],
          ),
        ),
      ),
    );
  }
}
