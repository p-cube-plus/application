import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Alarm {
  // Notifications Plugin 생성
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initState() async {
    // android 알림 설정: 아이콘 설정 가능
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // ios 알림 설정: 소리, 뱃지 등 설정 가능
    const initializationSettingsIOS = IOSInitializationSettings();

    // 알림 초기화
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    // onSelectNotification: 알림을 눌렀을때 어플에서 실행되는 행동을 설정
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  //알림을 눌렀을때 어떤 행동을 할지 정해주는 부분
  Future onSelectNotification(String? payload) async {
    print("payload : $payload");
  }

  // 알림 발생 함수
  Future<void> _showNotification() async {
    // android 알림 설정
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    // ios 알림 설정
    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();

    // 플랫폼별 설정
    const NotificationDetails details = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    // 알림 발생
    await flutterLocalNotificationsPlugin.show(
      0, // 단일 notification
      '알림 제목',
      '알림 내용',
      details,
    );
  }

  //반복적으로 알림을 뜨게 히는 방법
  Future _repeatNotification(int hour, int min, int sec) async {
    // android 알림 설정
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    // ios 알림 설정
    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();

    // 플랫폼별 설정
    const NotificationDetails details = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    // 알림 발생
    await flutterLocalNotificationsPlugin.periodicallyShow(
      0, // 단일 notification
      '알림 제목',
      '알림 내용',
      // ReapeatInterval.{EveryMinute, Hourly, Daily, Weekly} 중 선택
      RepeatInterval.weekly,
      details,
    );
  }
}
