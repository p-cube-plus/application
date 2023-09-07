import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p_cube_plus_application/main.dart';
import 'package:p_cube_plus_application/screens/main_page.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../utilities/contants.dart' as Constants;

class SplashPage extends StatelessWidget {
  const SplashPage({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/pcube+_logo_splash.json',
              width: 160,
              height: 160,
              repeat: false,
              // animate: false,
            ),
            SizedBox(height: 20),
            SvgPicture.asset('assets/images/pq-logo-text.svg'),
          ],
        ),
      ),
    );
  }
}
