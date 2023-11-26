import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
    required this.title,
    this.hasIcon = true,
    this.optionText,
    this.onTap,
  });
  final String title;
  final bool hasIcon;
  final Widget? optionText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.headline1!
                  .copyWith(fontSize: 14.0, fontWeight: FontWeight.w400),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: optionText ?? SizedBox(width: 0.0),
                ),
                hasIcon
                    ? Icon(Icons.chevron_right,
                        size: 24.0, color: theme.textTheme.headline2!.color)
                    : SizedBox(width: 0.0),
              ],
            )
          ],
        ),
      ),
    );
  }
}
