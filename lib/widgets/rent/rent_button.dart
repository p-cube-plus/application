import 'package:flutter/material.dart';

class RentButton extends StatelessWidget {
  const RentButton(
      {required this.text, required this.isActive, required this.isRent});
  final String text;
  final bool isActive;
  final bool isRent;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
          onPressed: () {},
          // onPressed: isActive
          //     ? () => showDialog(
          //         context: context,
          //         builder: (context) =>
          //         AlertFrame(
          //               messageType: MessageType.OKCancel,
          //               okText: isRent ? "대여" : "반납",
          //               children: [
          //                 Align(
          //                   child: Padding(
          //                     padding:
          //                         const EdgeInsets.only(top: 36, bottom: 16),
          //                     child: Column(
          //                       children: [
          //                         Text(
          //                           isRent ? '대여하기' : "반납하기",
          //                           style: theme.textTheme.headline1!.copyWith(
          //                             fontSize: 14,
          //                             fontWeight: FontWeight.w700,
          //                           ),
          //                         ),
          //                         SizedBox(height: 8),
          //                         Text(
          //                           isRent
          //                               ? '선택한 제품을 대여하시겠습니까?'
          //                               : "선택한 제품을 반납하시겠습니까?",
          //                           style: theme.textTheme.headline1!.copyWith(
          //                             fontSize: 12,
          //                             fontWeight: FontWeight.w400,
          //                           ),
          //                         ),
          //                         SizedBox(height: 8),
          //                       ],
          //                     ),
          //                   ),
          //                   alignment: Alignment.center,
          //                 ),
          //               ],
          //               okWidget: ScanPage(),
          //             )
          //             )
          //     : null,
          child: Text(
            text,
            style: isActive
                ? TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)
                : theme.textTheme.headline3!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          style: isActive
              ? theme.elevatedButtonTheme.style
              : ButtonStyle(
                  side: theme.elevatedButtonTheme.style!.side,
                  backgroundColor:
                      MaterialStateProperty.all(theme.disabledColor),
                  shape: theme.elevatedButtonTheme.style!.shape,
                  minimumSize: theme.elevatedButtonTheme.style!.minimumSize,
                )),
    );
  }
}
