import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:elite/main.dart';
import 'package:elite/model/QuizModels.dart';
import 'package:elite/utils/AppWidget.dart';
import 'package:elite/utils/QuizColors.dart';
import 'package:elite/utils/QuizConstant.dart';
import 'package:elite/utils/QuizDataGenerator.dart';
import 'package:elite/utils/QuizStrings.dart';

class QuizProfile extends StatefulWidget {
  static String tag = '/QuizProfile';

  @override
  _QuizProfileState createState() => _QuizProfileState();
}

class _QuizProfileState extends State<QuizProfile> {
  late List<QuizBadgesModel> mList;
  late List<QuizScoresModel> mList1;

  @override
  void initState() {
    super.initState();
    mList1 = quizScoresData();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    final imgview = Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Icon(Icons.light_mode, color: Colors.amber),
                Switch(
                  value: appStore.isDarkModeOn,
                  activeColor: appColorPrimary,
                  onChanged: (s) {
                    appStore.toggleDarkMode(value: s);
                  },
                ),
                Icon(Icons.dark_mode,
                    color: appStore.isDarkModeOn ? Colors.white : Colors.black),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            width: width,
            decoration: boxDecoration(
                radius: spacing_middle,
                bgColor: context.cardColor,
                showShadow: false),
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: <Widget>[
                text(
                  quiz_lbl_Scores,
                  fontSize: textSizeMedium,
                  fontFamily: fontSemibold,
                  isCentered: true,
                  textColor:
                      appStore.isDarkModeOn ? white : quiz_textColorPrimary,
                ),
              ],
            ),
          ),
          Container(
              decoration: boxDecoration(
                  bgColor: context.cardColor, radius: 10, showShadow: true),
              width: MediaQuery.of(context).size.width - 32,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: mList1.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              CachedNetworkImage(
                                placeholder: placeholderWidgetFn() as Widget
                                    Function(BuildContext, String)?,
                                imageUrl: mList1[index].img,
                                height: 50,
                                width: 50,
                                fit: BoxFit.fill,
                              )
                                  .cornerRadiusWithClipRRect(25)
                                  .paddingOnly(right: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(mList1[index].title,
                                      style: boldTextStyle(
                                          color: appStore.isDarkModeOn
                                              ? white
                                              : quiz_textColorPrimary)),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      text(mList1[index].totalQuiz,
                                          textColor: quiz_textColorSecondary),
                                      text(mList1[index].scores,
                                          textColor: quiz_textColorSecondary,
                                          fontSize: textSizeMedium,
                                          fontFamily: fontRegular)
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ).paddingAll(8),
                      ))).paddingOnly(bottom: 16)
        ],
      ),
    ).center();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Container(color: context.cardColor, child: imgview),
        ),
      ),
    );
  }
}
