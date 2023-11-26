import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/projects/projects_page.dart';
import 'package:p_cube_plus_application/screens/user_informations/user_information_page.dart';
import '../utilities/contants.dart' as Constants;

import 'fee/fee_page.dart';
import 'home/home_page.dart';
import 'notice/notice_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _idx = 2;
  final _pageController = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) => setState(() => _idx = index),
        children: [
          ProjectsPage(),
          FeePage(),
          HomePage(),
          NoticePage(),
          UserInformationPage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //showSelectedLabels: false,
        //showUnselectedLabels: false,
        iconSize: 20,
        selectedFontSize: 8,
        unselectedFontSize: 8,
        selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        items: [
          _getBar("프로젝트", Constants.Icons.projects,
              Constants.Icons.selected_projects),
          _getBar("회비", Constants.Icons.fee, Constants.Icons.selected_fee),
          _getBar("홈", Constants.Icons.home, Constants.Icons.selected_home),
          _getBar("알림", Constants.Icons.bell, Constants.Icons.selected_bell),
          _getBar("마이", Constants.Icons.user, Constants.Icons.selected_user),
        ],
        onTap: (int index) {
          _pageController.jumpToPage(index);
        },
        currentIndex: _idx,
      ),
    );
  }

  _getBar(String lebel, String icon, String selectedIcon) {
    final theme = Theme.of(context);
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.only(bottom: 4),
        child: Constants.Icons.GetIcon(
          icon,
          color: theme.bottomNavigationBarTheme.unselectedItemColor,
        ),
      ),
      activeIcon: Container(
        padding: EdgeInsets.only(bottom: 4),
        child: Constants.Icons.GetIcon(
          selectedIcon,
          color: theme.bottomNavigationBarTheme.selectedItemColor,
        ),
      ),
      label: lebel,
    );
  }
}
