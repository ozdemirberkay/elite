// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:elite/utils/QuizColors.dart';
import 'package:elite/utils/QuizConstant.dart';

import '../main.dart';

Widget text(
  String? text, {
  var fontSize = textSizeLargeMedium,
  Color? textColor,
  var fontFamily,
  var isCentered = false,
  var maxLine = 1,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily ?? null,
      fontSize: fontSize,
      color: textColor ?? appStore.textSecondaryColor,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

Widget? Function(BuildContext, String) placeholderWidgetFn() =>
    (_, s) => placeholderWidget();

Widget placeholderWidget() => Image.asset('images/grey.jpg', fit: BoxFit.cover);

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color? bgColor,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? appStore.scaffoldBackground,
    boxShadow: showShadow
        ? defaultBoxShadow(shadowColor: shadowColorGlobal)
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

class CustomTheme extends StatelessWidget {
  final Widget? child;

  CustomTheme({required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appStore.isDarkModeOn
          ? ThemeData.dark().copyWith(
              accentColor: appColorPrimary,
              backgroundColor: context.scaffoldBackgroundColor,
            )
          : ThemeData.light(),
      child: child!,
    );
  }
}
