// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/Screens/article_details.dart';
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

class Articles extends StatefulWidget {
  static String tag = '/QuizDetails';
  final String categoryID;
  final String cateGoryTitle;

  const Articles(
      {Key? key, required this.categoryID, required this.cateGoryTitle})
      : super(key: key);
  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
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
    List<QuizTestModel> mList = quizGetData();
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

            articleList = snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              Article article = Article(
                  imgUrl: data["imgUrl"],
                  title: data["title"],
                  body: data["body"],
                  id: data["id"]);

              return article;
            }).toList();

            return Column(
              children: <Widget>[
                quizTopBar(widget.cateGoryTitle + " Makaleleri"),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      text("Makaleleri Oku Quizleri Çöz",
                          isLongText: true,
                          fontFamily: fontBold,
                          isCentered: true,
                          fontSize: textSizeXLarge),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: articleList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return quizList(
                                articleList[index], widget.categoryID);
                          }),
                    ],
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

class quizList extends StatelessWidget {
  late var width;
  late Article article;
  late String category;

  quizList(Article article, String category) {
    this.article = article;
    this.category = category;
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
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(article.imgUrl),
              ),
              16.width,
              Expanded(child: Text(article.title, style: boldTextStyle())),
            ],
          ),
          16.height,
          Text(article.body.substring(1, 100) + "...",
              style: primaryTextStyle(color: quiz_textColorSecondary)),
          16.height,
          quizButton(
              textContent: "Makaleyi Oku",
              onPressed: () {
                ArticleDetails(
                  categoryId: category,
                  articleId: article.id,
                ).launch(context);
              })
        ],
      ),
    );
  }
}
