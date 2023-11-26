import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/pcube+_logo_loading.json',
              width: 160,
              height: 160,
              repeat: true,
              // animate: false,
            ),
            SizedBox(height: 40),
            Text('회원 정보를 조회하고 있어요.',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
            SizedBox(height: 4),
            Text('잠시만 기다려주세요!',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
