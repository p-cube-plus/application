import 'package:flutter/material.dart';
import 'login_page.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        heightFactor: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text('로그아웃 되었습니다.',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w700)),
                    ),
                    Text('다시 로그인 하시려면',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                    Text('홈으로 돌아가기를 눌러주세요.',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 48, horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text('홈으로 돌아가기'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(400, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
