// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:elite/model/QuizModels.dart';
import 'package:elite/utils/AppWidget.dart';
import 'package:elite/utils/QuizColors.dart';
import 'package:elite/utils/QuizConstant.dart';
import 'package:elite/utils/QuizDataGenerator.dart';
import 'package:elite/utils/QuizWidget.dart';

import '../main.dart';
import 'quiz_card.dart';

class ArticleDetails extends StatefulWidget {
  static String tag = '/QuizDetails';
  final String categoryID;

  const ArticleDetails({Key? key, required this.categoryID}) : super(key: key);
  @override
  _ArticleDetailsState createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  late List<QuizTestModel> mList;

  @override
  void initState() {
    super.initState();
    mList = quizGetData();
  }

  List<QuizTestModel> mListings = [];

  @override
  Widget build(BuildContext context) {
    final DocumentReference<Map<String, dynamic>> articles = FirebaseFirestore
        .instance
        .collection('categories')
        .doc(widget.categoryID);

    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: articles.get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Expanded(
                child: Center(
                    child: CircularProgressIndicator(
                  color: appStore.isDarkModeOn ? Colors.white : Colors.black,
                )),
              );
            }
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            QuizTestModel quizTestModel = QuizTestModel();
            quizTestModel.image = data["imgUrl"].toString();
            quizTestModel.heading = "Eklenecek";
            quizTestModel.description = "Burası da eklencek";
            mListings.add(quizTestModel);

            //   var article =
            //       snapshot.data!.data().map((DocumentSnapshot document) {
            //     Map<String, dynamic> data =
            //         document.data()! as Map<String, dynamic>;
            //     QuizTestModel quizTestModel = QuizTestModel();
            //     quizTestModel.image = data["imgUrl"].toString();
            //     quizTestModel.heading = "Eklenecek";
            //     quizTestModel.description = "Burası da eklencek";
            //     mListings.add(quizTestModel);
            //   }).toList();

            return Column(
              children: <Widget>[
                quizTopBar(widget.categoryID + " Makaleleri"),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        text("quiz_lbl_biology_amp_scientific_method",
                            isLongText: true,
                            fontFamily: fontBold,
                            isCentered: true,
                            fontSize: textSizeXLarge),
                        text("quiz_text_4_to_8_lesson",
                            textColor: quiz_textColorSecondary),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: mList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return quizList(mList[index], index);
                            }),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class quizList extends StatelessWidget {
  late var width;
  late QuizTestModel model;

  quizList(QuizTestModel model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    width = context.width();
    return Container(
      margin: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
      decoration: boxDecoration(
          radius: 10, showShadow: true, bgColor: context.cardColor),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: quiz_color_setting),
                width: width / 6.5,
                height: width / 6.5,
                padding: const EdgeInsets.all(10),
                child: Image.asset(model.image),
              ),
              16.width,
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     Text(model.type,
              //         style:
              //             secondaryTextStyle(color: quiz_textColorSecondary)),
              //     4.height,
              //     Text(model.heading, style: boldTextStyle()),
              //   ],
              // )
            ],
          ),
          16.height,
          Text(model.description,
              style: primaryTextStyle(color: quiz_textColorSecondary)),
          16.height,
          quizButton(
              textContent: "Quize Başla",
              onPressed: () {
                QuizCards().launch(context);
              })
        ],
      ),
    );
  }
}
