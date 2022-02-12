// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:elite/utils/AppWidget.dart';
import 'package:elite/utils/QuizColors.dart';
import 'package:elite/utils/QuizConstant.dart';
import 'package:elite/utils/QuizImages.dart';
import 'package:url_launcher/url_launcher.dart';

class QuizResult extends StatefulWidget {
  static String tag = '/QuizResult';

  const QuizResult({
    Key? key,
  }) : super(key: key);

  @override
  _QuizResultState createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 8),
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: IconButton(
                  icon: Icon(Icons.close, color: quiz_icon_color),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 190.0,
                      lineWidth: 10.0,
                      animation: true,
                      arcType: ArcType.FULL,
                      percent: 1.0,
                      backgroundColor: quiz_view_color,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          text("100", fontSize: 20.0, fontFamily: fontBold),
                          text("5 out 5", textColor: quiz_textColorSecondary),
                        ],
                      ),
                      progressColor: quiz_colorAccent,
                    ),
                    text("You are awesome!",
                        fontFamily: fontMedium, fontSize: textSizeLargeMedium),
                    text("Congratulations for getting\nall the answer correct!",
                        isLongText: true, textColor: quiz_textColorSecondary),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
