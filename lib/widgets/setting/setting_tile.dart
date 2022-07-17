import 'package:flutter/material.dart';

// NewPageTile: 클릭 시 새 페이지로 넘어가는 설정
// SwitchTile: 스위치 기능의 설정
// alertTile: 클릭 시 alert창이 나오는 설정

// versionTile: 현재 앱버전을 알기 위한 특수한 설정
// mainTitleTile: AppBar 역할의 설정 텍스트
// subTextTile: 설정 구분을 위한 텍스트

abstract class SettingTile extends StatelessWidget {
  final height = 50.0;
  final blank = 20.0;
  final default_padding = EdgeInsets.symmetric(horizontal: 20.0);
  final background = Colors.white70;
  final title;

  SettingTile({required String this.title});
}
