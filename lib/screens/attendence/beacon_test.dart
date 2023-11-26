import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/page/default_appbar.dart';
import 'package:p_cube_plus_application/widgets/page/default_page.dart';
import 'package:permission_handler/permission_handler.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> with WidgetsBindingObserver {
  var isRunning = false;
  bool _isReady = false;
  String _results = "";

  final ScrollController _scrollController = ScrollController();

  final StreamController<String> beaconEventsController =
      StreamController<String>.broadcast();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPlatformState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() async {
    await BeaconsPlugin.clearRegions();
    beaconEventsController.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> initPlatformState() async {
    // 블루투스의 위치 정보를 얻기 위해 사용
    var status = await Permission.location.status;
    if (!(status.isGranted)) {
      await Permission.location.request();
    }

    // 블루투스 모듈에 접근 권한
    status = await Permission.bluetooth.status;
    if (!(status.isGranted)) {
      await Permission.bluetooth.request();
    }

    // 주변 블루투스 검색 권한
    status = await Permission.bluetoothScan.status;
    if (!(status.isGranted)) {
      await Permission.bluetoothScan.request();
    }

    // 명시적으로 권한부여 메시지를 띄움
    if (Platform.isAndroid) {
      await BeaconsPlugin.setDisclosureDialogMessage(
          title: "권한 부여", message: "해당 앱은 블루투스 및 위치를 켜야 정상작동합니다.");
      await BeaconsPlugin.clearDisclosureDialogShowFlag(false);
    }

    if (Platform.isAndroid) {
      BeaconsPlugin.channel.setMethodCallHandler((call) async {
        if (call.method == 'scannerReady') {
          await BeaconsPlugin.startMonitoring();
        } else if (call.method == 'isPermissionDialogShown') {}
      });
    }

    print("모니터링 시작");
    BeaconsPlugin.setDebugLevel(2);

    // 스캔 시 함수 호출 세팅
    BeaconsPlugin.listenToBeacons(beaconEventsController);

    // UUID 변경 금지
    print("비콘 등록중");
    await BeaconsPlugin.addRegion(
            "Pcube+", "e2c56db5-dffb-48d2-b060-d0f5a71096e0")
        .then((value) => print("비콘 등록 완료"));

    // iBeacon은 Andriod에서 필요
    print("레이아웃 등록중");
    await BeaconsPlugin.addBeaconLayoutForAndroid(
        "m:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24");

    // foreground 세팅
    print("스캔 설정중");
    await BeaconsPlugin.setForegroundScanPeriodForAndroid(
        foregroundScanPeriod: 2200, foregroundBetweenScanPeriod: 5);

    // background 세팅
    // BeaconsPlugin.setBackgroundScanPeriodForAndroid(
    //     backgroundScanPeriod: 2200, backgroundBetweenScanPeriod: 5);

    // 스캔 시 지속적으로 불리는 함수
    beaconEventsController.stream.listen(
        (data) async {
          if (data.isNotEmpty && _results.compareTo("") == 0) {
            setState(() {
              _results = data;
            });
            await StopMonitoring();
          } else {
            print(
                "data: ${data.isNotEmpty}, isRunning: ${isRunning}, result: ${_results}");
          }
        },
        onDone: () {},
        onError: (error) {
          print("Error: $error");
        });

    _isReady = true;

    if (!mounted) return;
  }

  // 준비가 될 때까지 100ms씩 기다림
  Future<void> waitForReady() async {
    while (!_isReady) {
      await Future.delayed(Duration(milliseconds: 100));
      print("준비대기");
    }
  }

  Future<void> StartMonitoring() async {
    await waitForReady();
    setState(() {
      isRunning = true;
    });
    await BeaconsPlugin.startMonitoring();
  }

  Future<void> StopMonitoring() async {
    await BeaconsPlugin.stopMonitoring();
    setState(() {
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appbar: DefaultAppBar(
        centerTitle: '비콘 탐색',
      ),
      content: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('총 개수: ${_results == "" ? 0 : 1}',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      )),
            )),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (!isRunning) {
                    await StartMonitoring();
                  } else {
                    await StopMonitoring();
                  }
                },
                child: Text(isRunning ? '중지' : '시작',
                    style: TextStyle(fontSize: 20)),
              ),
            ),
            Visibility(
              visible: _results.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _results = "";
                    });
                  },
                  child: Text("초기화", style: TextStyle(fontSize: 20)),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(child: _buildResultsList())
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList() {
    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        controller: _scrollController,
        itemCount: _results == "" ? 0 : 1,
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 1,
          color: Colors.black,
        ),
        itemBuilder: (context, index) {
          DateTime now = DateTime.now();
          String formattedDate =
              DateFormat('yyyy-MM-dd – kk:mm:ss.SSS').format(now);
          final item = ListTile(
              title: Text(
                "Time: $formattedDate\n$_results",
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontSize: 14,
                      color: const Color(0xFF1A1B26),
                      fontWeight: FontWeight.normal,
                    ),
              ),
              onTap: () {});
          return item;
        },
      ),
    );
  }
}
