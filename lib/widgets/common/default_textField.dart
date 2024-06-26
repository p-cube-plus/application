import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    this.minLine,
    this.maxLine,
    required this.maxLength,
    this.hintText,
    this.fontSize = 10.0,
    this.contentPadding = 8.0,
    this.textType,
    required this.inputController,
    this.inputFormatters,
    this.autofocus,
    this.focusNode,
  });

  final int? minLine;
  final int? maxLine;
  final int maxLength;
  final String? hintText;
  final double fontSize;
  final double contentPadding;
  final TextInputType? textType;
  final TextEditingController inputController;
  final List<TextInputFormatter>? inputFormatters;
  final bool? autofocus;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextField(
      textAlignVertical: TextAlignVertical.bottom,
      focusNode: focusNode,
      minLines: minLine ?? 1,
      maxLines: maxLine ?? minLine ?? 1,
      maxLength: maxLength,
      keyboardType: textType,
      cursorColor: theme.textTheme.displayLarge!.color,
      style: theme.textTheme.displayLarge!
          .copyWith(fontSize: fontSize, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          helperMaxLines: 0,
          errorMaxLines: 0,
          contentPadding: EdgeInsets.all(contentPadding),
          counterText: "", // 글자수 제한 보이기 삭제
          hintText: hintText,
          hintStyle: theme.textTheme.displaySmall!.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.0, style: BorderStyle.none))),
      //toolbarOptions: ToolbarOptions(copy: true),
      controller: inputController,
      autofocus: autofocus == null ? false : autofocus!,
      inputFormatters: inputFormatters,
      selectionControls: CustomTextSelectionControls(),
    );
  }
}

class CustomTextSelectionControls extends TextSelectionControls {
  double _kHandleSize = 22.0;
  late bool isCollapsed;

  @override
  Widget buildHandle(
      BuildContext context, TextSelectionHandleType type, double textLineHeight,
      [VoidCallback? onTap]) {
    switch (type) {
      case TextSelectionHandleType.left:
        return GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: onTap,
          child: Container(
            width: _kHandleSize,
            height: _kHandleSize,
            decoration: BoxDecoration(
              color: Theme.of(context).textSelectionTheme.selectionHandleColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11.0),
                bottomLeft: Radius.circular(11.0),
                bottomRight: Radius.circular(11.0),
              ),
            ),
          ),
        );
      case TextSelectionHandleType.right:
        return GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: onTap,
          child: Container(
            width: _kHandleSize,
            height: _kHandleSize,
            decoration: BoxDecoration(
              color: Theme.of(context).textSelectionTheme.selectionHandleColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(11.0),
                bottomLeft: Radius.circular(11.0),
                bottomRight: Radius.circular(11.0),
              ),
            ),
          ),
        );
      case TextSelectionHandleType.collapsed:
        return GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: onTap,
          child: Transform.rotate(
            angle: 45 * 3.1415926535 / 180,
            child: Container(
              width: _kHandleSize,
              height: _kHandleSize,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).textSelectionTheme.selectionHandleColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(11.0),
                  bottomLeft: Radius.circular(11.0),
                  bottomRight: Radius.circular(11.0),
                ),
              ),
            ),
          ),
        );
    }
  }

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    switch (type) {
      case TextSelectionHandleType.left:
        return Offset(_kHandleSize, 0);
      case TextSelectionHandleType.right:
        isCollapsed = false;
        return Offset.zero;
      case TextSelectionHandleType.collapsed:
        isCollapsed = true;
        return Offset(9.85, textLineHeight - 17.5);
    }
  }

  @override
  Size getHandleSize(double textLineHeight) {
    return Size.square(_kHandleSize);
  }

  @override
  Widget buildToolbar(
      BuildContext context,
      Rect globalEditableRegion,
      double textLineHeight,
      Offset selectionMidpoint,
      List<TextSelectionPoint> endpoints,
      TextSelectionDelegate delegate,
      ValueListenable<ClipboardStatus>? clipboardStatus,
      Offset? lastSecondaryTapDownPosition) {
    final List<Widget> items = <Widget>[];
    final TextStyle style = Theme.of(context).textTheme.displayLarge!.copyWith(
          fontSize: 13.0,
          fontWeight: FontWeight.w700,
        );

    if (delegate.cutEnabled && !isCollapsed) {
      items.add(TextButton(
        onPressed: () => delegate.cutSelection(SelectionChangedCause.toolbar),
        child: Text('잘라내기', style: style),
      ));
    }
    if (delegate.copyEnabled && !isCollapsed) {
      items.add(TextButton(
        onPressed: () => delegate.copySelection(SelectionChangedCause.toolbar),
        child: Text('복사', style: style),
      ));
    }
    if (delegate.pasteEnabled) {
      items.add(TextButton(
        onPressed: () => delegate.pasteText(SelectionChangedCause.toolbar),
        child: Text('붙여넣기', style: style),
      ));
    }

    if (delegate.selectAllEnabled) {
      items.add(TextButton(
        onPressed: () => delegate.selectAll(SelectionChangedCause.toolbar),
        child: Text('전체선택', style: style),
      ));
    }

    return TextSelectionToolbar(
      children: items,
      toolbarBuilder: (context, widget) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Color(0x11000000),
                blurRadius: 10.0,
                spreadRadius: 0.0,
                offset: Offset.fromDirection(1, 7),
              )
            ],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: widget),
      anchorAbove: Offset(
        globalEditableRegion.left + selectionMidpoint.dx,
        globalEditableRegion.top + endpoints[0].point.dy - textLineHeight - 8,
      ),
      anchorBelow: Offset(
        globalEditableRegion.left + selectionMidpoint.dx,
        globalEditableRegion.top +
            (endpoints.length > 1 ? endpoints[1] : endpoints[0]).point.dy +
            _kHandleSize,
      ),
    );
  }
}
