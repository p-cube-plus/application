import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/screens/attendence/attendance_page.dart';
import 'package:p_cube_plus_application/screens/rent/rent_page.dart';
import 'package:provider/provider.dart';
import 'package:scan/scan.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/home/content_summary_view.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';
import '../rent/scan_page.dart';
import '../../models/rent.dart';
import '../../providers/rent_provider.dart';
import '../../widgets/calendar/calendar.dart';
import '../../widgets/calendar/Home/calendar_summary_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme currentTheme = Theme.of(context).textTheme;
    return DefaultPage(
      title: "홈",
      content: DefaultContent(
        child: Column(
          children: [
            Attendence(),
            HomeCalendar(
              currentTheme: currentTheme,
            ),
            RentListView(),
          ],
        ),
      ),
      floatingActionButton: FloatingBarcodeButton(),
    );
  }
}

class Attendence extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: ContentSummaryView(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AttendancePage(),
              ),
            );
          },
          title: "출석체크",
          titleFontSize: 16.0,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RoundedBorder(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendancePage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 7.0,
                            width: 7.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFE55542)),
                          ),
                          SizedBox(width: 12),
                          Text("2022.08.17"),
                          SizedBox(width: 8),
                          Text("판도라큐브 정기회의"),
                        ],
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            )
          ]),
    );
  }
}

class HomeCalendar extends StatefulWidget {
  const HomeCalendar({
    Key? key,
    required this.currentTheme,
  }) : super(key: key);

  final TextTheme currentTheme;

  @override
  State<HomeCalendar> createState() => _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  DateTime _selectedDate = DateTime.now();
  DateTime _viewDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CalendarMonthlySummaryView(
          viewDate: _viewDate,
        ),
        RoundedBorder(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
          child: Calendar(
            onSelectedDateChanged: (date) =>
                setState(() => _selectedDate = date),
            onViewDateChanged: (date) => setState(() {
              _viewDate = date;
            }),
            isHomeCalendar: true,
          ),
        ),
        if (_viewDate.month == _selectedDate.month &&
            _viewDate.difference(_selectedDate).inDays.abs() < 32)
          CalendarDailySummaryView(
            selectedDate: _selectedDate,
          )
        else
          Container(),
      ]..add(SizedBox(height: 20.0)),
    );
  }
}

class RentListView extends StatelessWidget {
  const RentListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rentProvider = context.watch<RentProvider>();

    return ContentSummaryView(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RentPage(),
          ),
        );
      },
      title: "대여한 물품",
      titleFontSize: 16.0,
      children: List.generate(
        rentProvider.rentList?.length ?? 0,
        (index) {
          Rent? rent = rentProvider.getRent(index);
          if (rent == null) return Container();

          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: RoundedBorder(
              //height: 56.0,
              hasShadow: true,
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          rent.product.name, // debug
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        SizedBox(height: 2.5),
                        Text(
                          "${DateFormat("yyyy/MM/dd").format(rent.rentDay)} 에 대여함",
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ],
                    ),
                    Text(
                      rent.dDay == 0
                          ? "D-Day"
                          : "D${rent.dDay.sign == -1 ? "+" : "-"}${rent.dDay}",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            color: rent.dDay > 7
                                ? null
                                : Theme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FloatingBarcodeButton extends StatefulWidget {
  @override
  _FloatingBarcodeButton createState() => _FloatingBarcodeButton();
}

class _FloatingBarcodeButton extends State<FloatingBarcodeButton> {
  String _platformVersion = 'Unknown';
  String qrcode = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("code: $qrcode");
    return SizedBox(
      width: 64,
      height: 64,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ScanPage();
          }));
        },
        elevation: 7.68,
        focusElevation: 7.68,
        hoverElevation: 7.68,
        disabledElevation: 7.68,
        highlightElevation: 7.68,
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Image.asset(
            "assets/images/scan.png",
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
