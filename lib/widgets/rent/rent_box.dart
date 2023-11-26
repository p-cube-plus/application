import 'package:flutter/material.dart';

import '../../models/rent.dart';
import '../common/rounded_border.dart';

class RentBox extends StatelessWidget {
  const RentBox({
    Key? key,
    required this.rent,
  }) : super(key: key);

  final Rent rent;

  @override
  Widget build(BuildContext context) {
    //var parent = context.findAncestorStateOfType<RentItemListViewState>();
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: RoundedBorder(
        color: rent.product.isAvailable
            ? Theme.of(context).cardColor
            : Theme.of(context).dialogBackgroundColor,
        height: 48,
        width: double.infinity,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: rent.product.isAvailable ? () {} : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                  ),
                  Text(rent.product.name,
                      style: rent.product.isAvailable
                          ? Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w500)
                          : Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w500))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 9, horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(rent.product.category,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: 11, fontWeight: FontWeight.w700)),
                      Text(rent.product.location ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize: 11, fontWeight: FontWeight.w400)),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
