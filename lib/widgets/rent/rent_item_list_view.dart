import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/rent_provider.dart';
import 'package:provider/provider.dart';

import 'button_page.dart';
import 'rent_box.dart';

class RentItenListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonPage(
      names: ["전체", "대여 가능", "대여 중"],
      contents: [RentItemView(), RentItemView(), RentItemView()],
    );
  }
}

class RentItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rentProvider = context.watch<RentProvider>();

    if (!rentProvider.loaded) return Center(child: CircularProgressIndicator());

    if (rentProvider.fail)
      return Center(child: Text(rentProvider.errorMessage!));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
            itemCount: rentProvider.rentList!.length,
            itemBuilder: (BuildContext context, int index) {
              return RentBox(rent: rentProvider.rentList![index]);
            }),
      ],
    );
  }
}
