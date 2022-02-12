// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/model/article.dart';
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
  List<Article> articleList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> articles = FirebaseFirestore.instance
        .collection('categories/${widget.categoryID}/articles')
        .snapshots();
    ;

    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: articles,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Expanded(
                child: Center(
                    child: CircularProgressIndicator(
                        color: appStore.isDarkModeOn
                            ? Colors.white
                            : Colors.black)),
              );
            }

            /**
        
            var article =
                 snapshot.data!.data().map((DocumentSnapshot document) {
               Map<String, dynamic> data =
                   document.data()! as Map<String, dynamic>;
               QuizTestModel quizTestModel = QuizTestModel();
               quizTestModel.image = data["imgUrl"].toString();
               quizTestModel.heading = "Eklenecek";
               quizTestModel.description = "Burası da eklencek";
               mListings.add(quizTestModel);
             }).toList();

       */

            articleList = snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              Article article = Article();
              article.id = document.id;
              article.title = data["title"];

              return article;
            }).toList();

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
                            itemCount: articleList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Text(articleList[index].title.toString());
                              // return quizList(articleList[index].toString(), index);
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
