import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p_cube_plus_application/providers/api_provider/naver_login.dart';
import 'package:p_cube_plus_application/providers/api_provider/notice_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/project_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/rent_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/schedule_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/user_profile_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/user_project_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/user_warning_provider.dart';
import 'package:p_cube_plus_application/providers/view_provider/fee_provider.dart';
import 'package:p_cube_plus_application/providers/view_provider/setting_provider.dart';
import 'package:p_cube_plus_application/providers/view_provider/theme_provider.dart';
import 'package:p_cube_plus_application/providers/view_provider/filter_provider.dart';
import 'package:p_cube_plus_application/screens/executives/executive_page.dart';
import 'package:p_cube_plus_application/screens/login/login_page.dart';
import 'package:p_cube_plus_application/utilities/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  // beacon 설정
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      ChangeNotifierProvider(create: (_) => UserProfileProvider()),
      ChangeNotifierProvider(create: (_) => UserProjectProvider()),
      ChangeNotifierProvider(create: (_) => UserWarningProvider()),
      ChangeNotifierProvider(create: (_) => UserProjectListProvider()),
      ChangeNotifierProvider(create: (_) => FilterProvider()),
    ],
    child: MyApp(),
  ));
}

// TODO: home 이 LoginPage인지 MainPage인지 확인하는 로직 추가 필요
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
      home: ExecutivePage(), //LoginPage(), //ExecutivePage(),
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
