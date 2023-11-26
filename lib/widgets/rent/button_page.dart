import 'package:flutter/material.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({
    Key? key,
    required this.names,
    required this.contents,
  }) : super(key: key);

  final List<String> names;
  final List<Widget> contents;

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _rowChildren = <Widget>[];

    for (var i = 0; i < widget.names.length; ++i) {
      if (i != _index)
        _rowChildren.add(Padding(
          child: _getInactiveButton(i, widget.names[i]),
          padding: EdgeInsets.only(right: 6),
        ));
      else
        _rowChildren.add(Padding(
          child: _getActiveButton(i, widget.names[i]),
          padding: EdgeInsets.only(right: 6),
        ));
    }

    return Column(
      children: [
        Row(children: _rowChildren),
        Padding(
            padding: EdgeInsets.only(top: 24), child: widget.contents[_index]),
      ],
    );
  }

  Widget _getInactiveButton(index, name) {
    var theme = Theme.of(context);
    return SizedBox(
        height: 23,
        child: OutlinedButton(
          onPressed: () => setState(() {
            _index = index;
          }),
          child: Text(
            name,
            style: theme.textTheme.headline1!
                .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          style: theme.outlinedButtonTheme.style!.copyWith(
              backgroundColor: MaterialStateProperty.all(theme.cardColor)),
        ));
  }

  Widget _getActiveButton(index, name) {
    return SizedBox(
      height: 23,
      child: ElevatedButton(
          onPressed: () => setState(() {
                _index = index;
              }),
          child: Text(
            name,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          style: Theme.of(context).elevatedButtonTheme.style),
    );
  }
}
