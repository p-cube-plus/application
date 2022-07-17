import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/screens/user_informations/user_information_page.dart';
import '../../utilities/contants.dart' as Constants;

import 'home_page.dart';
import 'notice_page.dart';

class PageControll extends StatefulWidget {
  @override
  State<PageControll> createState() => _PageControllState();
}

class _PageControllState extends State<PageControll> {
  int _idx = 1;
  final pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (int index) {
          setState(() {
            _idx = index;
          });
        },
        children: [
          NoticePage(),
          HomePage(),
          UserInformationPage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 32,
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Constants.Icons.GetIcon(
              Constants.Icons.bell,
              color: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
            ),
            activeIcon: Constants.Icons.GetIcon(
              Constants.Icons.selected_bell,
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            ),
            label: '알림',
          ),
          BottomNavigationBarItem(
            icon: Constants.Icons.GetIcon(
              Constants.Icons.home,
              color: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
            ),
            activeIcon: Constants.Icons.GetIcon(
              Constants.Icons.selected_home,
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Constants.Icons.GetIcon(
              Constants.Icons.user,
              color: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
            ),
            activeIcon: Constants.Icons.GetIcon(
              Constants.Icons.selected_user,
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            ),
            label: '설정',
          ),
        ],
        onTap: (int index) {
          pageController.jumpToPage(index);
        },
        currentIndex: _idx,
      ),
    );
  }
}
