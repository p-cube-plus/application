import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Icons {
  static String naver = "assets/images/icons/naver.svg";
  static String main_logo = "assets/images/icons/main_logo.svg";
  static String main_text_logo = "assets/images/icons/pcube_text_logo.svg";
  static String input = "assets/images/icons/input.svg";
  static String cancle = "assets/images/icons/cancle.svg";

  static String projects = "assets/images/icons/projects.svg";
  static String fee = "assets/images/icons/fee.svg";
  static String home = "assets/images/icons/home.svg";
  static String bell = "assets/images/icons/bell.svg";
  static String user = "assets/images/icons/user.svg";
  static String send = "assets/images/icons/send.svg";

  static String selected_projects = "assets/images/icons/projects_selected.svg";
  static String selected_fee = "assets/images/icons/fee_selected.svg";
  static String selected_home = "assets/images/icons/home_selected.svg";
  static String selected_bell = "assets/images/icons/bell_selected.svg";
  static String selected_user = "assets/images/icons/user_selected.svg";

  static String left_arrow = "assets/images/icons/arrow_left.svg";
  static String right_arrow = "assets/images/icons/arrow_right.svg";
  static String copy = "assets/images/icons/copy.svg";
  static String check = "assets/images/icons/check.svg";

  static String profile = "assets/images/icons/profile.svg";
  static String general = "assets/images/icons/general.svg";
  static String pencil = "assets/images/icons/pencil.svg";
  static String pcube_logo = "assets/images/icons/pcube_logo.svg";

  static String filter = "assets/images/icons/filter.svg";
  static String watch = "assets/images/icons/watch.svg";

  static String list_active = "assets/images/icons/list_check_active.svg";
  static String list_inactive = "assets/images/icons/list_check_inactive.svg";

  static Widget GetIcon(String icon, {Color? color}) =>
      SvgPicture.asset(icon, color: color);
}
/*
import '../../utilities/contants.dart' as Constants;
Constants.Icons.GetIcon(Constants.Icons.main_logo),
*/
