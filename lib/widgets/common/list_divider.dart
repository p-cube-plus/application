import 'package:flutter/material.dart';

class ListDivider extends StatelessWidget {
  const ListDivider({
    this.thickness,
    this.vertial = 0.0,
    this.horizontal = 0.0,
  });

  final double? vertial, horizontal, thickness;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: vertial ?? 0.0, horizontal: horizontal ?? 0.0),
      child: Divider(
        thickness: thickness ?? 1.0,
      ),
    );
  }
}
