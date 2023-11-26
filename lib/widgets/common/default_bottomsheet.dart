import 'package:flutter/material.dart';

class DefaultBottomsheet extends StatelessWidget {
  const DefaultBottomsheet(
      {required this.title, this.contents, this.bottomPadding = 56});
  final String title;
  final List<Widget>? contents;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Center(
          child: Container(
            height: 4,
            width: 64,
            color: Theme.of(context).dialogBackgroundColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 36, bottom: 32),
          child: Text(title,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  )),
        ),
      ]
        ..addAll(contents ?? [SizedBox()])
        ..add(SizedBox(height: bottomPadding)),
    );
  }
}


// showModalBottomSheet(
//   isScrollControlled: true,
//             shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
//             context: context,
//             builder: (context) => DefaultBottomsheet(
//                   title: "",
//                   contents: [],
//                 )),
