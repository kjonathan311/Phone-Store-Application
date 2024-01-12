import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Bold = FontWeight.w700;
const SemiBold = FontWeight.w600;
const Medium = FontWeight.w500;
const Regular = FontWeight.w400;

class Themes {
  final Colours colors;
  final TextStyles styles = TextStyles();
  final String suffix;

  Themes({required this.colors, required this.suffix});

  SvgPicture getSvgPicture(String name, {double? width, double? height, Key? key}) => SvgPicture.asset(
        'assets/$name$suffix.svg',
        width: width,
        height: height,
        key: key,
      );
}

class Colours {
  final Color primary,
      border,
      appBar,
      banner,
      card,
      row,
      modelSheet,
      bottomBar,
      background,
      selectedItemBackground,
      error,
      fail,
      pending,
      success,
      done,
      text1,
      text2,
      text3,
      text4,
      text5,
      text6,
      text7,
      text8,
      text9,
      text10,
      text11,
      text12,
      text13,
      disabled,
      divider,
      button1,
      button2,
      button3,
      button4,
      btnText1,
      gradientStart1,
      gradientEnd1,
      dot,
      onboardingTitle;

  Colours({
    required this.primary,
    required this.border,
    required this.banner,
    required this.card,
    required this.modelSheet,
    required this.row,
    required this.bottomBar,
    required this.appBar,
    required this.background,
    required this.selectedItemBackground,
    required this.error,
    required this.fail,
    required this.success,
    required this.done,
    required this.pending,
    required this.gradientStart1,
    required this.gradientEnd1,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.text6,
    required this.text7,
    required this.text8,
    required this.text9,
    required this.text10,
    required this.text11,
    required this.text12,
    required this.text13,
    required this.disabled,
    required this.dot,
    required this.button1,
    required this.button2,
    required this.button3,
    required this.button4,
    required this.divider,
    required this.onboardingTitle,
    required this.btnText1,
  });
}

class TextStyles {
  final TextStyle title1,
      title2,
      title3,
      title4,
      title5,
      subTitle1,
      subTitle2,
      subTitle3,
      subTitle4,
      subTitle5,
      subTitle6,
      subTitle7,
      body1,
      body2,
      body3,
      body4,
      body5,
      body6,
      body7,
      button1,
      button2,
      button3,
      button4,
      bottomLabel1,
      bottomLabel2;

  TextStyles({
    this.title1 = const TextStyle(fontWeight: Bold, fontSize: 34),
    this.title2 = const TextStyle(fontWeight: Bold, fontSize: 24),
    this.title3 = const TextStyle(fontWeight: Bold, fontSize: 22),
    this.title4 = const TextStyle(fontWeight: Bold, fontSize: 20),
    this.title5 = const TextStyle(fontWeight: Bold, fontSize: 18),
    this.subTitle1 = const TextStyle(fontWeight: Medium, fontSize: 25),
    this.subTitle2 = const TextStyle(fontWeight: Medium, fontSize: 20),
    this.subTitle3 = const TextStyle(fontWeight: Medium, fontSize: 18),
    this.subTitle4 = const TextStyle(fontWeight: Medium, fontSize: 17),
    this.subTitle5 = const TextStyle(fontWeight: Medium, fontSize: 16),
    this.subTitle6 = const TextStyle(fontWeight: Medium, fontSize: 15),
    this.subTitle7 = const TextStyle(fontWeight: Medium, fontSize: 14),
    this.body1 = const TextStyle(fontWeight: Regular, fontSize: 17),
    this.body2 = const TextStyle(fontWeight: Regular, fontSize: 16),
    this.body3 = const TextStyle(fontWeight: Regular, fontSize: 15),
    this.body4 = const TextStyle(fontWeight: Regular, fontSize: 14),
    this.body5 = const TextStyle(fontWeight: Regular, fontSize: 12),
    this.body6 = const TextStyle(fontWeight: Regular, fontSize: 10),
    this.body7 = const TextStyle(fontWeight: Regular, fontSize: 9),
    this.button1 = const TextStyle(fontWeight: SemiBold, fontSize: 16),
    this.button2 = const TextStyle(fontWeight: SemiBold, fontSize: 14),
    this.button3 = const TextStyle(fontWeight: SemiBold, fontSize: 11),
    this.button4 = const TextStyle(fontWeight: SemiBold, fontSize: 11),
    this.bottomLabel1 = const TextStyle(fontWeight: SemiBold, fontSize: 12),
    this.bottomLabel2 = const TextStyle(fontWeight: SemiBold, fontSize: 12),
  });
}
