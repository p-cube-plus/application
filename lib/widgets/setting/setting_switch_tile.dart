import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:p_cube_plus_application/providers/setting_provider.dart';
import 'package:provider/provider.dart';

class SwitchTile extends StatelessWidget {
  SwitchTile({required this.title, required this.type});

  final String title;
  final SettingType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingProvider = Provider.of<SettingProvider>(context);
    settingProvider.changeState(type);
    bool _value = settingProvider.isOn;
    return InkWell(
      onTap: () {
        settingProvider.changeState(type);
        _value = !_value;
        settingProvider.toggle(_value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(title,
                style: theme.textTheme.headline1!
                    .copyWith(fontSize: 14.0, fontWeight: FontWeight.w400)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            // Switch.adaptive
            // CupertinoSwitch
            // Switch
            child: FlutterSwitch(
              width: 32,
              height: 16,
              activeColor: Theme.of(context).primaryColor,
              value: _value,
              toggleSize: 12,
              borderRadius: 50,
              padding: 2,
              onToggle: (value) {
                settingProvider.changeState(type);
                _value = value;
                settingProvider.toggle(_value);
              },
            ),
          )
        ],
      ),
    );
  }
}
