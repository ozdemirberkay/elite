import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:elite/utils/AppWidget.dart';
import 'package:elite/utils/QuizColors.dart';
import 'package:elite/utils/QuizConstant.dart';
import 'package:elite/utils/QuizStrings.dart';
import 'package:elite/utils/QuizWidget.dart';

class QuizUpdateEmail extends StatefulWidget {
  static String tag = '/QuizUpdateEmail';

  @override
  _QuizUpdateEmailState createState() => _QuizUpdateEmailState();
}

class _QuizUpdateEmailState extends State<QuizUpdateEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text(quiz_lbl_Update_email,
            fontSize: textSizeNormal, fontFamily: fontMedium),
        iconTheme: IconThemeData(color: quiz_colorPrimary, size: 24),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                16.height,
                text(quiz_info_Update_email,
                        textColor: quiz_textColorSecondary,
                        isLongText: true,
                        isCentered: true)
                    .center(),
                Container(
                  margin: EdgeInsets.all(24.0),
                  decoration: boxDecoration(
                      bgColor: context.cardColor, showShadow: true, radius: 10),
                  child: Column(
                    children: <Widget>[
                      quizEditTextStyle(quiz_hint_your_email,
                          isPassword: false),
                    ],
                  ),
                ),
                8.height,
                Text(quiz_lbl_email_Verify, style: secondaryTextStyle()).onTap(
                  () {
                    finish(context);
                  },
                ),
                50.height,
                Container(
                  margin: EdgeInsets.all(24.0),
                  child: quizButton(
                    textContent: quiz_lbl_save,
                    onPressed: () {
                      setState(
                        () {
                          finish(context);
                          toasty(context, quiz_Successfully_Email_Updated);
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
