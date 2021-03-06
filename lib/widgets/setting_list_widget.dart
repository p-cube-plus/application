import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/icon_widget.dart';

class SettingListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('설정'),
          automaticallyImplyLeading: false,
          //leading: IconButton(
          //  icon: const Icon(Icons.arrow_back),
          //  color: Color.fromARGB(255, 0, 0, 0),
          //  tooltip: '뒤로 가기',
          //  onPressed: () {
          //    Navigator.pop(context);
          //  },
          //),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 0),
            children: [
              const SizedBox(height: 32),
            ],
          ),
        ));
  }
}
