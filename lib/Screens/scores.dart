import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:elite/main.dart';
import 'package:elite/model/QuizModels.dart';
import 'package:elite/utils/AppWidget.dart';
import 'package:elite/utils/QuizColors.dart';
import 'package:elite/utils/QuizConstant.dart';
import 'package:elite/utils/QuizDataGenerator.dart';

class Scores extends StatefulWidget {
  static String tag = '/Scores';

  @override
  _ScoresState createState() => _ScoresState();
}

class _ScoresState extends State<Scores> {
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
          /* Container(
            width: width,
            decoration: boxDecoration(
                radius: spacing_middle,
                bgColor: context.cardColor,
                showShadow: false),
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: <Widget>[
                text(
                  "Skorlar",
                  fontSize: textSizeLarge,
                  fontFamily: fontSemibold,
                  isCentered: true,
                  textColor:
                      appStore.isDarkModeOn ? white : quiz_textColorPrimary,
                ),
              ],
            ),
          ),
       */
          const SizedBox(height: 16),
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
        appBar: AppBar(
          title: text(
            "Skorlar",
            fontSize: textSizeLarge,
            fontFamily: fontSemibold,
            isCentered: true,
            textColor: appStore.isDarkModeOn ? white : quiz_textColorPrimary,
          ),
          actions: [
            appStore.isDarkModeOn
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          appStore.toggleDarkMode(value: false);
                        },
                        child: Icon(Icons.light_mode, color: Colors.amber)),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          appStore.toggleDarkMode(value: true);
                        },
                        child: Icon(Icons.dark_mode,
                            color: appStore.isDarkModeOn
                                ? Colors.white
                                : Colors.black)),
                  ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Container(color: context.cardColor, child: imgview),
        ),
      ),
    );
  }
}
