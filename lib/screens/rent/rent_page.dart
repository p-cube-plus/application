import 'package:flutter/material.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_page.dart';
import '../../widgets/page/default_tabbar.dart';
import '../../widgets/rent/rent_item_list_view.dart';
import '../../widgets/rent/rented_item_list_view.dart';
import 'rent_search_page.dart';

class RentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "물품",
      appbar: DefaultAppBar(),
      action: GestureDetector(
        child: Image.asset(
          "assets/images/search.png",
          color: Theme.of(context).textTheme.headline1!.color,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RentSearchPage(),
            ),
          );
        },
      ),
      content: DefaultTabBar(tabs: [
        DefaultTab(title: "대여하기", page: RentItenListView()),
        DefaultTab(title: "내가 대여한", page: RentedItemListView())
      ]),
    );
  }
}
