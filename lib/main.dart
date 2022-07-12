import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/providers/setting_provider.dart';
import 'package:p_cube_plus_application/utilities/theme.dart';
import 'package:provider/provider.dart';

import 'providers/notice_provider.dart';

import 'screens/login_page.dart';
import 'utilities/notification.dart';

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 이후, 앱 시작 시 필요한 정보나 요청을 다 받고
  // FlutterNativeSplash.remove();

  //WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NoticeProvider()),
      ChangeNotifierProvider(create: (_) => SettingProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<SettingProvider>(context);
    themeProvider.changeState(SettingType.Theme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PCube+', // 탭 이름
      themeMode: themeProvider.item,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: LoginPage(),
    );
  }
}
