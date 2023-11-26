import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/executive/notification/required_text.dart';
import '../../../utilities/contants.dart' as Constants;
import '../../common/default_textField.dart';
import '../../common/rounded_border.dart';

class NotificationInput extends StatelessWidget {
  const NotificationInput(this.text);
  final RequiredText text;

  @override
  Widget build(BuildContext context) {
    final controller = new TextEditingController();
    return RoundedBorder(
      width: double.infinity,
      height: 56,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 20),
          text,
          SizedBox(width: 16),
          Container(
            height: 32,
            width: 1,
            color: Theme.of(context).dividerColor,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              child: DefaultTextField(
                  hintText: "내용을 입력하세요",
                  fontSize: 14,
                  maxLength: 50,
                  maxLine: 1,
                  inputController: controller),
            ),
          ),
          SizedBox(
              width: 20,
              height: 20,
              child: Constants.Icons.GetIcon(Constants.Icons.input)),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
