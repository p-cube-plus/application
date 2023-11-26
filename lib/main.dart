import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p_cube_plus_application/providers/fee_provider.dart';
import 'package:p_cube_plus_application/providers/naver_login.dart';
import 'package:p_cube_plus_application/providers/project_provider.dart';
import 'package:p_cube_plus_application/providers/rent_provider.dart';
import 'package:p_cube_plus_application/providers/schedule_provider.dart';
import 'package:p_cube_plus_application/providers/setting_provider.dart';
import 'package:p_cube_plus_application/providers/theme_provider.dart';
import 'package:p_cube_plus_application/providers/user_data_provider.dart';
import 'package:p_cube_plus_application/screens/loading.dart';
import 'package:p_cube_plus_application/screens/login_page.dart';
import 'package:p_cube_plus_application/screens/splash.dart';
import 'package:p_cube_plus_application/utilities/theme.dart';
import 'package:provider/provider.dart';

import 'providers/notice_provider.dart';

void main() {
  // beacon 설정
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NaverLoginProvider()),
      ChangeNotifierProvider(create: (_) => FeeProvider()),
      ChangeNotifierProvider(create: (_) => NoticeProvider()),
      ChangeNotifierProvider(create: (_) => ProjectProvider()),
      ChangeNotifierProvider(create: (_) => RentProvider()),
      ChangeNotifierProvider(create: (_) => ScheduleProvider()),
      ChangeNotifierProvider(create: (_) => SettingProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => UserDataProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    SystemChrome.setSystemUIOverlayStyle(
        themeProvider.brightness == Brightness.light
            ? SystemUiOverlayStyle.dark.copyWith(
                systemStatusBarContrastEnforced: false,
                systemNavigationBarContrastEnforced: false,
                statusBarColor: Colors.transparent,
              )
            : SystemUiOverlayStyle.light.copyWith(
                systemStatusBarContrastEnforced: false,
                systemNavigationBarContrastEnforced: false,
                statusBarColor: Colors.transparent,
              ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PCube+', // 탭 이름
      themeMode: themeProvider.type,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: LoadingPage(), // SplashPage(),
      // AttendancePage(), // MainPage(), //AttendencePage(), //ExecutivePage(),
      scrollBehavior: _RemoveGlowEffect(),
    );
  }
}

class _RemoveGlowEffect extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;
}
