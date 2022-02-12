import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:elite/Screens/QuizDetails.dart';
import 'package:elite/model/QuizModels.dart';
import 'package:elite/utils/AppWidget.dart';
import 'package:elite/utils/QuizColors.dart';
import 'package:elite/utils/QuizConstant.dart';
import 'package:elite/utils/QuizDataGenerator.dart';
import 'package:elite/utils/QuizImages.dart';
import 'package:elite/utils/QuizStrings.dart';

class QuizListing extends StatefulWidget {
  static String tag = '/QuizListing';

  @override
  _QuizListingState createState() => _QuizListingState();
}

class _QuizListingState extends State<QuizListing> {
  late List<NewQuizModel> mListings;

  var selectedGrid = true;
  var selectedList = false;

  @override
  void initState() {
    super.initState();
    mListings = getQuizData();
  }

  Widget listing() {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: mListings.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            setState(
              () {
                QuizDetails().launch(context);
              },
            );
          },
          child: Container(
            decoration: boxDecoration(
                radius: 16, showShadow: true, bgColor: context.cardColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  alignment: Alignment.topRight,
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
                          fit: BoxFit.cover),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      text(mListings[index].quizName,
                          fontSize: textSizeMedium,
                          isLongText: true,
                          fontFamily: fontMedium),
                      const SizedBox(height: 8),
                      text(mListings[index].totalQuiz,
                          textColor: quiz_textColorSecondary),
                    ],
                  ),
                ),
              ],
            ),
          ).paddingOnly(bottom: spacing_standard_new),
        ),
      ),
    );
  }

  Widget gridList() {
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

          //decoration: boxDecoration(radius: 16, showShadow: true, bgColor: quiz_white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
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
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0)),
                  color: context.cardColor,
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
                        .paddingOnly(left: 16, right: 16, bottom: 16),
                  ],
                ),
              ),
            ],
          ),
        ).cornerRadiusWithClipRRect(16).onTap(() {
          QuizDetails().launch(context);
        });
      },
      //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.58, crossAxisSpacing: 16, mainAxisSpacing: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text(quiz_lbl_new_quiz,
            fontSize: textSizeLargeMedium, fontFamily: fontMedium),
        iconTheme: const IconThemeData(color: quiz_colorPrimary, size: 24),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Image.asset(
                      Quiz_ic_Grid,
                      height: 20,
                      width: 20,
                      color: selectedGrid ? quiz_colorPrimary : quiz_light_gray,
                    ).onTap(() {
                      setState(() {
                        selectedList = false;
                        selectedGrid = true;
                      });
                    }).paddingOnly(top: 8, right: 16),
                    Image.asset(
                      Quiz_ic_List,
                      height: 20,
                      width: 20,
                      color: selectedList ? quiz_colorPrimary : quiz_light_gray,
                    ).onTap(() {
                      setState(() {
                        selectedList = true;
                        selectedGrid = false;
                      });
                    }).paddingOnly(top: 8, right: 16),
                  ],
                ),
                SingleChildScrollView(
                    child: Container(
                  margin: const EdgeInsets.all(16),
                  child: selectedGrid ? gridList() : listing(),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
