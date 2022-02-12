import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<NewQuizModel> mListings = [];

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categories =
        FirebaseFirestore.instance.collection('categories').snapshots();

    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: text(
              "KATEGORİLER",
              fontSize: textSizeLarge,
              isCentered: true,
              fontFamily: fontMedium,
              textColor: appStore.isDarkModeOn ? white : quiz_textColorPrimary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: categories,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                var category =
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  NewQuizModel newQuizModel = NewQuizModel();
                  newQuizModel.quizImage = data["categoryImgUrl"].toString();
                  newQuizModel.quizName = data["title"].toString();
                  newQuizModel.totalQuiz = "10 Makale";
                  mListings.add(newQuizModel);
                }).toList();

                return StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                  scrollDirection: Axis.vertical,
                  itemCount: mListings.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0)),
                            child: CachedNetworkImage(
                              placeholder: placeholderWidgetFn() as Widget
                                  Function(BuildContext, String)?,
                              imageUrl: mListings[index].quizImage,
                              height: context.width() * 0.4,
                              width: MediaQuery.of(context).size.width / 0.25,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
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
                                    .paddingOnly(
                                        top: 8, left: 16, right: 16, bottom: 8),
                                text(mListings[index].totalQuiz,
                                        textColor: quiz_textColorSecondary)
                                    .paddingOnly(
                                        left: 16, right: 16, bottom: 16),
                                LinearProgressIndicator(
                                  value: 0.5,
                                  backgroundColor:
                                      textSecondaryColor.withOpacity(0.2),
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(quiz_green),
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
              },
            ),
          ),
        ],
      )),
    );
  }
}
