import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:elite/model/QuizModels.dart';
import 'package:elite/utils/AppWidget.dart';
import 'package:elite/utils/QuizColors.dart';
import 'package:elite/utils/QuizConstant.dart';
import 'package:elite/utils/QuizDataGenerator.dart';

import '../main.dart';
import 'quiz_details.dart';

class Categories extends StatefulWidget {
  static String tag = '/Categories';

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late List<NewQuizModel> mListings;

  @override
  void initState() {
    super.initState();
    mListings = getQuizData();
  }

  Widget quizAll() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      scrollDirection: Axis.vertical,
      itemCount: mListings.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(16.0),
                    topRight: const Radius.circular(16.0)),
                child: CachedNetworkImage(
                  placeholder: placeholderWidgetFn() as Widget Function(
                      BuildContext, String)?,
                  imageUrl: mListings[index].quizImage,
                  height: context.width() * 0.4,
                  width: MediaQuery.of(context).size.width / 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: const Radius.circular(16.0)),
                  // color: quiz_white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    text(mListings[index].quizName,
                            fontSize: textSizeMedium,
                            maxLine: 2,
                            fontFamily: fontMedium)
                        .paddingOnly(top: 8, left: 16, right: 16, bottom: 8),
                    text(mListings[index].totalQuiz,
                            textColor: quiz_textColorSecondary)
                        .paddingOnly(left: 16, right: 16, bottom: 8),
                  ],
                ),
              ),
            ],
          ),
        ).cornerRadiusWithClipRRect(16).onTap(() {
          QuizDetails().launch(context);
        });
      },
      //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.67, mainAxisSpacing: 16, crossAxisSpacing: 16),
    );
  }

  Widget quizCompleted() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      scrollDirection: Axis.vertical,
      itemCount: mListings.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0)),
                child: CachedNetworkImage(
                  placeholder: placeholderWidgetFn() as Widget Function(
                      BuildContext, String)?,
                  imageUrl: mListings[index].quizImage,
                  height: context.width() * 0.4,
                  width: MediaQuery.of(context).size.width / 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0)),
                  color: context.cardColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    text(mListings[index].quizName,
                            fontSize: textSizeMedium,
                            maxLine: 2,
                            fontFamily: fontMedium)
                        .paddingOnly(top: 8, left: 16, right: 16, bottom: 8),
                    text(mListings[index].totalQuiz,
                            textColor: quiz_textColorSecondary)
                        .paddingOnly(left: 16, right: 16, bottom: 16),
                    LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: textSecondaryColor.withOpacity(0.2),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(quiz_green),
                    ).paddingOnly(left: 16, right: 16, bottom: 16),
                  ],
                ),
              ),
            ],
          ),
        ).cornerRadiusWithClipRRect(16).onTap(() {
          QuizDetails().launch(context);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40),
                Container(
                  width: width,
                  decoration: boxDecoration(
                      radius: spacing_middle,
                      bgColor: context.cardColor,
                      showShadow: false),
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: text(
                    "KATEGORİLER",
                    fontSize: textSizeMedium,
                    isCentered: true,
                    fontFamily: fontMedium,
                    textColor:
                        appStore.isDarkModeOn ? white : quiz_textColorPrimary,
                  ),
                ),
                SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8, left: 8),
                    child: quizCompleted(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}