// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:elite/Screens/NewQuiz.dart';
import 'package:elite/Screens/QuizDetails.dart';
import 'package:elite/model/QuizModels.dart';
import 'package:elite/utils/AppWidget.dart';
import 'package:elite/utils/QuizColors.dart';
import 'package:elite/utils/QuizDataGenerator.dart';
import 'package:elite/utils/QuizStrings.dart';
import 'package:elite/utils/QuizWidget.dart';
import 'QuizNewList.dart';

class QuizHome extends StatefulWidget {
  static String tag = '/QuizHome';

  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  late List<NewQuizModel> mListings;

  @override
  void initState() {
    super.initState();
    mListings = getQuizData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            32.height,
            Text(quiz_lbl_hi_antonio, style: boldTextStyle(size: 24)),
            8.height,
            Text(
              "Makaleleri okuyup, soruları cevapla",
              style: primaryTextStyle(color: quiz_textColorSecondary),
              textAlign: TextAlign.center,
            ),
            24.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(quiz_lbl_new_quiz, style: boldTextStyle(size: 18)),
                Text(
                  quiz_lbl_view_all,
                  style: primaryTextStyle(color: quiz_textColorSecondary),
                ).onTap(
                  () {
                    setState(
                      () {
                        QuizListing().launch(context);
                      },
                    );
                  },
                ),
              ],
            ).paddingAll(16),
            SizedBox(
              height: 255,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mListings.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) =>
                    NewQuiz(mListings[index], index).onTap(
                  () {
                    QuizDetails().launch(context);
                  },
                ),
              ),
            ).paddingOnly(bottom: 16),
          ],
        ),
      ),
    );
  }
}
