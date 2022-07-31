import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// 임시
import '../providers/naver_login.dart';
import 'mainpage/page_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

// Init Badge
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FlutterAppBadger.removeBadge();
    }
  }

// Init flutter_local_notification
  Future<void> _init() async {
    await _configureLocalTimeZone();
    await _initializeNotification();
  }

  // 현재 시간 등록
  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();

    try {
      print(timeZoneName);
      tz.setLocalLocation(tz.getLocation(timeZoneName!));
    } catch (e) {
      const String fallback = 'Asia/Seoul';
      tz.setLocalLocation(tz.getLocation(fallback));
      print("이거 오류야!!");
    }
  }

  Future<void> _initializeNotification() async {
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  //알림을 눌렀을때 어떤 행동을 할지 정해주는 부분
  Future _onSelectNotification(String? payload) async {
    print("payload : $payload");
  }

// 메시지 등록 취소
  Future<void> cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

// 알림 권한 요청
  Future<void> requestPermissions() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

// 메시지 등록
  Future<void> registerMessage({
    required int hour,
    required int minutes,
    required message,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'flutter_local_notifications',
      message,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
          priority: Priority.high,
          ongoing: true,
          styleInformation: BigTextStyleInformation(message),
          icon: 'ic_notification',
        ),
        iOS: const IOSNotificationDetails(
          badgeNumber: 1,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //body: Center(
      //  child: ElevatedButton(
      //    onPressed: () async {
      //      await cancelNotification();
      //      await requestPermissions();
      //      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      //      await registerMessage(
      //        hour: now.hour,
      //        minutes: now.minute + 1,
      //        message: 'Hello, world!',
      //      );
      //    },
      //    child: const Text('Show Notification'),
      //  ),
      //),
      body: const SingleChildScrollView(
        child: Center(
          child: _MainLogin(),
        ),
      ),
    );
  }
}

class _MainLogin extends StatelessWidget {
  const _MainLogin();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _ShowLogo(),
          _ShowButton(),
          _ShowTextButton(),
        ],
      ),
    );
  }
}

class _ShowLogo extends StatelessWidget {
  const _ShowLogo();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(image: AssetImage('assets/images/symbol.png')),
      height: 500,
      width: 500,
      margin: EdgeInsets.only(bottom: 60),
    );
  }
}

class _ShowButton extends StatelessWidget {
  const _ShowButton();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NaverLoginProvider>(
      create: (_) => NaverLoginProvider(),
      builder: (context, child) {
        return Container(
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            //buttonMinWidth: MediaQuery.of(context).size.width * 0.35,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ElevatedButton(
                  child: Row(
                    children: [
                      const Text(
                        "네이버 아이디로 로그인",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: MediaQuery.of(context).size.width * 0.2),
                    primary: Color(0xff2DB400), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    _goNaverPage(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _goNaverPage(BuildContext context) {
    context.read<NaverLoginProvider>().naverLogin(context);
  }
}

class _ShowTextButton extends StatelessWidget {
  const _ShowTextButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          //primary: Color.fromARGB(153, 75, 75, 75),
          textStyle: const TextStyle(
            fontSize: 14,
          ),
        ),
        child: const Text('동아리 가입 신청서 작성하기'),
        onPressed: () {
          _goApplicationPage(context);
        },
      ),
      margin: EdgeInsets.only(top: 5),
      height: 40,
      width: MediaQuery.of(context).size.width * 0.5,
    );
  }

  void _goApplicationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageControll()),
    );
  }
}
