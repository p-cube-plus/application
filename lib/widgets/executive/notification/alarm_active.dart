import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:p_cube_plus_application/widgets/common/rounded_border.dart';

class AlarmActive extends StatefulWidget {
  @override
  State<AlarmActive> createState() => _AlarmActiveState();
}

class _AlarmActiveState extends State<AlarmActive> {
  bool _value = true;

  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      onTap: () => setState(() => _value = !_value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("알림 꺼짐"),
          FlutterSwitch(
            width: 32,
            height: 16,
            activeColor: Theme.of(context).primaryColor,
            value: _value,
            toggleSize: 10,
            borderRadius: 50,
            padding: 2,
            onToggle: (value) => setState(() => _value = value),
          )
        ],
      ),
    );
  }
}
