import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:p_cube_plus_application/providers/view_provider/filter_provider.dart';
import 'package:p_cube_plus_application/utilities/theme.dart';
import 'package:p_cube_plus_application/widgets/common/default_bottomsheet.dart';
import 'package:p_cube_plus_application/widgets/common/rounded_border.dart';
import 'package:provider/provider.dart';
import '../../../utilities/contants.dart' as Constants;

class DefaultUserSearch<T extends UserSearchFilter> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      onTap: () => showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          context: context,
          builder: (context) => UserFilterBottomSheet<T>()),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      radius: 50,
      color: MyThemes.primary20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Constants.Icons.GetIcon(Constants.Icons.filter),
          SizedBox(width: 8),
          Text(
            "필터",
            style: TextStyle(
              color: MyThemes.primary80,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}

class UserFilterBottomSheet<T extends UserSearchFilter> extends StatefulWidget {
  @override
  State<UserFilterBottomSheet> createState() =>
      _UserFilterBottomSheetState<T>();
}

class _UserFilterBottomSheetState<T extends UserSearchFilter>
    extends State<UserFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var filterProvider = context.read<FilterProvider>();
    T source = filterProvider.getFilter<T>();
    T newFilter = filterProvider.createFilter(T) as T;
    newFilter.copy(source);

    return DefaultBottomsheet(
      title: "필터",
      contents: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("회원 분류",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
              SizedBox(height: 16),
              UserFilterTileWidget(
                  "활동 회원만 보기",
                  () =>
                      newFilter.isOnlyActiveUser = !newFilter.isOnlyActiveUser,
                  () => newFilter.isOnlyActiveUser),
              UserFilterTileWidget(
                  "임원진만 보기",
                  () => newFilter.isOnlyExecutive = !newFilter.isOnlyExecutive,
                  () => newFilter.isOnlyExecutive),
              SizedBox(height: 20),
              Text("파트 분류",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
              SizedBox(height: 16),
              UserFilterTileWidget(
                  "프로그래밍 파트 보기",
                  () => newFilter.isVisibleProgramer =
                      !newFilter.isVisibleProgramer,
                  () => newFilter.isVisibleProgramer),
              UserFilterTileWidget(
                  "아트 파트 보기",
                  () => newFilter.isVisibleArt = !newFilter.isVisibleArt,
                  () => newFilter.isVisibleArt),
              UserFilterTileWidget(
                  "기획 파트 보기",
                  () => newFilter.isVisibleDesign = !newFilter.isVisibleDesign,
                  () => newFilter.isVisibleDesign),
              SizedBox(height: 20),
              Text("정렬",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
              SizedBox(height: 16),
              SizedBox(
                height: 36,
                child: RoundedBorder(
                  hasShadow: false,
                  radius: 50,
                  color: Theme.of(context).textTheme.displaySmall!.color,
                  padding: const EdgeInsets.all(1),
                  child: RoundedBorder(
                    radius: 50,
                    hasShadow: false,
                    color: Theme.of(context).colorScheme.background,
                    padding: const EdgeInsets.all(3),
                    child: UserFilterSortWidget(
                      () => newFilter.sortType,
                      (value) => newFilter.sortType = value,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => filterProvider.changeFilter<T>(newFilter),
                    child: Text(
                      "필터 적용하기",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UserFilterTileWidget extends StatefulWidget {
  const UserFilterTileWidget(this.title, this.changeAction, this.getAction);
  final String title;
  final Function changeAction;
  final Function getAction;

  @override
  State<UserFilterTileWidget> createState() => _UserFilterTileWidgetState();
}

class _UserFilterTileWidgetState extends State<UserFilterTileWidget> {
  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      onTap: () => setState(() => widget.changeAction()),
      height: 32,
      color: Colors.transparent,
      hasShadow: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
          FlutterSwitch(
            width: 32,
            height: 16,
            activeColor: Theme.of(context).primaryColor,
            value: widget.getAction(),
            toggleSize: 10,
            borderRadius: 50,
            padding: 2,
            onToggle: (value) => setState(() => widget.changeAction()),
          ),
        ],
      ),
    );
  }
}

class UserFilterSortWidget extends StatefulWidget {
  const UserFilterSortWidget(this.getAction, this.setAction);
  final Function getAction;
  final Function setAction;

  @override
  State<UserFilterSortWidget> createState() => _UserFilterSortWidgetState();
}

class _UserFilterSortWidgetState extends State<UserFilterSortWidget> {
  @override
  Widget build(BuildContext context) {
    bool isActiveName = widget.getAction() == UserSearchSortType.Name;
    bool isActiveGroup = widget.getAction() == UserSearchSortType.Group;
    return Row(
      children: [
        Expanded(
          child: RoundedBorder(
            radius: 50,
            onTap: () =>
                setState(() => widget.setAction(UserSearchSortType.Name)),
            padding: const EdgeInsets.symmetric(vertical: 6),
            hasShadow: false,
            color: isActiveName ? MyThemes.primary20 : Colors.transparent,
            child: Text(
              "이름 순",
              textAlign: TextAlign.center,
              style: isActiveName
                  ? TextStyle(
                      color: MyThemes.primary80,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    )
                  : null,
            ),
          ),
        ),
        Expanded(
          child: RoundedBorder(
            radius: 50,
            onTap: () =>
                setState(() => widget.setAction(UserSearchSortType.Group)),
            padding: const EdgeInsets.symmetric(vertical: 6),
            hasShadow: false,
            color: isActiveGroup ? MyThemes.primary20 : Colors.transparent,
            child: Text(
              "회원구분 순",
              textAlign: TextAlign.center,
              style: isActiveGroup
                  ? TextStyle(
                      color: MyThemes.primary80,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
