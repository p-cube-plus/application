import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/rent/rent_search_list_view.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_page.dart';
import '../../widgets/rent/rent_button.dart';

class RentSearchPage extends StatefulWidget {
  @override
  State<RentSearchPage> createState() => _RentSearchPageState();
}

class _RentSearchPageState extends State<RentSearchPage> {
  String _productName = "";

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "검색",
      appbar: DefaultAppBar(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedBorder(
                radius: 50.0,
                color: Theme.of(context).inputDecorationTheme.fillColor,
                hasShadow: false,
                padding: EdgeInsets.only(left: 16.0),
                child: TextField(
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (value) {
                    _productName = value;
                  },
                  onSubmitted: (value) {
                    setState(() {
                      _productName = value;
                    });
                  },
                  textInputAction: TextInputAction.search,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                  decoration: InputDecoration(
                    hintText: "물품 이름, 종류 등",
                    hintStyle: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() {}),
                      child: Image.asset(
                        "assets/images/search.png",
                        color: Theme.of(context).textTheme.headline3!.color,
                        scale: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              if (_productName == "")
                Text(
                  "원하는 물품을 검색해서\n대여해보세요.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                )
              else
                RentSearchListView(
                  productName: _productName,
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: RentButton(text: "대여하기", isActive: true, isRent: true),
          ),
        ],
      ),
    );
  }
}
