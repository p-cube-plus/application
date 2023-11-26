import 'package:flutter/material.dart';

class DefaultTab {
  DefaultTab({
    required this.title,
    required this.page,
  });
  final String title;
  final Widget page;
}

class DefaultTabBar extends StatefulWidget {
  const DefaultTabBar({
    Key? key,
    required this.tabs,
    this.isCenter = false,
    this.tabHeight = 2,
  }) : super(key: key);

  final List<DefaultTab> tabs;
  final bool isCenter;
  final double tabHeight;

  @override
  State<DefaultTabBar> createState() => _DefaultTabBarState();
}

class _DefaultTabBarState extends State<DefaultTabBar>
    with TickerProviderStateMixin {
  int pageIndex = 0;
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: widget.tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: widget.isCenter ? Alignment.center : Alignment.centerLeft,
          child: TabBar(
            tabs: [
              for (int i = 0; i < widget.tabs.length; ++i)
                Container(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(widget.tabs[i].title)))
            ],
            controller: controller,
            physics: const PageScrollPhysics(),
            indicatorSize: widget.isCenter
                ? TabBarIndicatorSize.tab
                : TabBarIndicatorSize.label,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
              width: 2.0,
              color: theme.tabBarTheme.labelColor!,
            )),
            isScrollable: !widget.isCenter,
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 12.0),
            unselectedLabelStyle: theme.tabBarTheme.unselectedLabelStyle,
            labelStyle: theme.tabBarTheme.labelStyle,
            labelPadding: EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: widget.tabHeight,
                top: widget.tabHeight),
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: const PageScrollPhysics(),
            controller: controller,
            children: [
              for (int i = 0; i < widget.tabs.length; ++i) widget.tabs[i].page
            ],
          ),
        ),
      ],
    );

    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     // 상단탭 부분
    //     Padding(
    //       padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 12.0),
    //       child: Row(
    //         children: List.generate(widget.tabs.length, (index) {
    //           return GestureDetector(
    //             onTap: () => setState(() => pageIndex = index),
    //             child: Padding(
    //               padding: EdgeInsets.symmetric(
    //                 horizontal: index > 0 ? 16.0 : 0,
    //               ),
    //               child: Container(
    //                 height: 28.0,
    //                 decoration: pageIndex == index
    //                     ? BoxDecoration(
    //                         border: Border(
    //                             bottom: BorderSide(
    //                         color: theme.tabBarTheme.labelColor!,
    //                         width: 2.0,
    //                       )))
    //                     : null,
    //                 child: Column(
    //                   mainAxisSize: MainAxisSize.min,
    //                   children: [
    //                     Padding(
    //                       padding: EdgeInsets.only(
    //                           left: 4, right: 4, top: 4, bottom: 2),
    //                       child: Text(
    //                         widget.tabs[index].title,
    //                         style: pageIndex == index
    //                             ? theme.tabBarTheme.labelStyle
    //                             : theme.tabBarTheme.unselectedLabelStyle,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           );
    //         }),
    //       ),
    //     ),

    //     // 내용부분
    //     Expanded(
    //         child: GestureDetector(
    //       onHorizontalDragStart: (details) =>
    //           startX = details.globalPosition.dx,
    //       onHorizontalDragUpdate: (details) {
    //         endX = details.localPosition.dx;
    //       },
    //       onHorizontalDragEnd: (details) {
    //         setState(() {
    //           if (endX - startX > 50.0)
    //             --pageIndex;
    //           else if (startX - endX > 50.0) ++pageIndex;
    //           if (pageIndex < 0)
    //             pageIndex = widget.tabs.length - 1;
    //           else if (pageIndex >= widget.tabs.length) pageIndex = 0;
    //         });
    //       },
    //       child: DefaultContent(child: widget.tabs[pageIndex].page),
    //     )),
    //   ],
    // );
  }
}
