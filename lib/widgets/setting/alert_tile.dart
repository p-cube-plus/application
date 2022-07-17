import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/setting/setting_tile.dart';

class AlertTile extends SettingTile {
  final alertWidget;
  final hasIcon;
  AlertTile(
      {required String title,
      required Widget this.alertWidget,
      required bool this.hasIcon})
      : super(title: title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: super.height,
      child: InkWell(
        onTap: () {
          showDialog(context: context, builder: (context) => alertWidget);
        },
        child: Container(
          child: Padding(
            padding: super.default_padding,
            child: Row(
              children: _getChildren(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getChildren() {
    final result = <Widget>[];
    //result.add(SizedBox(width: super.blank));
    result.add(Text(super.title));
    if (hasIcon) {
      result.add(const Spacer());
      result.add(Icon(Icons.arrow_forward_ios, size: 15));
      //result.add(SizedBox(width: super.blank));
    }
    return result;
  }
}
