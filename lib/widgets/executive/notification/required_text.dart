import 'package:flutter/material.dart';

class RequiredText extends StatelessWidget {
  const RequiredText({required this.text, this.isRequired = true});
  final String text;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isRequired ? "* " : "   ",
          style: TextStyle(color: Color(0xE6D82828), fontSize: 14),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
