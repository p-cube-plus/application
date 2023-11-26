import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/oauth_token.dart';
import '../services/oauth_api.dart';
import '../screens/main_page.dart';

class NaverLoginProvider with ChangeNotifier {
  late String nName, nGender, nBirth;

  Future<void> naverLogin(BuildContext context) async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();

    switch (res.status) {
      case NaverLoginStatus.loggedIn:
        NaverAccessToken token = await FlutterNaverLogin.currentAccessToken;
        OAuthToken? oAuthToken = await OAuthAPI().naver(token.refreshToken,
            res.account.id, res.account.name, res.account.mobile);

        if (oAuthToken?.accessToken != null) {
          Fluttertoast.showToast(
              msg: "${res.account.name}님! 로그인에 성공했어요 :)",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            //System.isLogin = true;
            return MainPage();
          }));
        } else {
          Fluttertoast.showToast(
              msg: "${res.account.name}님! 로그인에 실패했어요 :(",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
        }
        break;
      case NaverLoginStatus.cancelledByUser:
        // 유저에 의해 cancel
        break;
      case NaverLoginStatus.error:
        // error
        break;
    }

    //notifyListeners();
  }

  void naverLogout() {
    FlutterNaverLogin.logOut();
  }
}
