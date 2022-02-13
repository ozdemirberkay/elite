import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/Screens/quiz_card.dart';
import 'package:elite/utils/AppWidget.dart';
import 'package:elite/utils/QuizColors.dart';
import 'package:elite/utils/QuizConstant.dart';
import 'package:elite/utils/QuizWidget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/article.dart';

class ArticleDetails extends StatefulWidget {
  String categoryId;
  String articleId;
  ArticleDetails({Key? key, required this.categoryId, required this.articleId})
      : super(key: key);

  @override
  _ArticleDetailsState createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  @override
  Widget build(BuildContext context) {
    Article2 article = Article2(
      question: [],
    );
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .collection("articles")
        .doc(widget.articleId);

    return StreamBuilder<DocumentSnapshot>(
        stream: documentReference.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.close, color: quiz_icon_color),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          article.title = data["title"].toString();
          article.body = data["body"].toString();
          article.imgUrl = data["imgUrl"].toString();
          //article.question = data["title"].toString();
          return Scaffold(
              body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.close, color: quiz_icon_color),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        text(article.title.toString(), fontSize: textSizeLarge),
                  ),
                  SizedBox(
                    height: 300,
                    child: Image(
                      image: NetworkImage(article.imgUrl.toString()),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(article.body.toString()),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12.0),
                    child: quizButton(
                      textContent: "Quize Başla",
                      onPressed: () {
                        QuizCards(
                          categoryId: widget.categoryId,
                          articleId: widget.articleId,
                        ).launch(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ));
        });
  }
}

/**
 * 
 * Stream<QuerySnapshot> stream = _db.collection("tblcustomers").snapshots();
  jsonObject = Customers(error: false, errorCode: 0, Items: List<Customers_items>());
  stream.forEach((QuerySnapshot element) {
    if (element == null) return;

    setState(() {
      jsonObject.Items = element.documents.map((e) => Customers_items.fromJson(e.data)).toList();
    });
  });

 */