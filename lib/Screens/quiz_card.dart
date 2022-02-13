import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/model/article.dart';
import 'package:elite/model/question.dart';
import 'package:elite/utils/QuizWidget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:elite/Screens/quiz_result.dart';
import 'package:elite/main.dart';
import 'package:elite/utils/AppWidget.dart';
import 'package:elite/utils/QuizCard.dart';
import 'package:elite/utils/QuizColors.dart';
import 'package:elite/utils/QuizConstant.dart';

class QuizCards extends StatefulWidget {
  static String tag = '/QuizCards';
  String categoryId;
  String articleId;
  QuizCards({Key? key, required this.categoryId, required this.articleId})
      : super(key: key);

  @override
  _QuizCardsState createState() => _QuizCardsState();
}

class _QuizCardsState extends State<QuizCards> {
  List<Widget> cardList = [];
  Article2 article = Article2(question: []);

  void removeCards(index) {
    setState(() {
      cardList.removeAt(index);
    });
  }

  void initialize() async {
    DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
        .instance
        .collection('categories')
        .doc(widget.categoryId)
        .collection("articles")
        .doc(widget.articleId)
        .get();

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    article.title = data["title"].toString();
    article.body = data["body"].toString();
    article.imgUrl = data["imgUrl"].toString();
    article.question.add(Question(
      id: "1",
    ));
    print(article.title);
    cardList = _generateCards(article);
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    Article2 article = Article2(question: []);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .collection("articles")
        .doc(widget.articleId);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              child: Stack(alignment: Alignment.center, children: cardList),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      finish(context);
                    },
                    icon: const Icon(Icons.close, color: quiz_colorPrimary),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: textSecondaryColor.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        quiz_green,
                      ),
                    ).paddingAll(16),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _generateCards(Article2 article) {
    List<Quiz> planetCard = [];

    planetCard.add(
      Quiz("How many basic steps are there in scientific method?",
          "Eight Steps", "Ten Steps", "Two Steps", "One Steps", 70.0),
    );
    planetCard.add(
      Quiz("Which blood vessels have the smallest diameter? ", "Capillaries",
          "Arterioles", "Venules", "Lymphatic", 80.0),
    );
    planetCard.add(Quiz("The substrate of photo-respiration is", "Phruvic acid",
        "Glucose", "Fructose", "Glycolate", 90.0));

    planetCard.add(Quiz("Which one of these animal is jawless?", "Shark",
        "Myxine", "Trygon", "Sphyrna", 100.0));
    planetCard.add(
      Quiz("How many basic steps are there in scientific method?",
          "Eight Steps", "Ten Steps", "One Steps", "Three Steps", 110.0),
    );
    for (var element in article.question) {
      planetCard.add(
        Quiz("added?", "Eight Steps", "Ten Steps", "Two Steps", "One Steps",
            70.0),
      );
    }
    List<Widget> cardList = [];

    for (int x = 0; x < planetCard.length; x++) {
      cardList.add(
        Positioned(
          top: planetCard[x].topMargin,
          child: Draggable(
            onDragEnd: (drag) {
              if (x == 0) {
                setState(() {
                  const QuizResult().launch(context);
                });
              }
              removeCards(x);
            },
            childWhenDragging: Container(),
            feedback: Material(
              child: GestureDetector(
                child: Container(
                  decoration: boxDecoration(
                      radius: 20,
                      bgColor:
                          appStore.isDarkModeOn ? cardDarkColor : quiz_white,
                      showShadow: true),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 200.0,
                        width: 320.0,
                        child: Container(
                          margin: const EdgeInsets.only(top: 50),
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                          child: text(planetCard[x].cardImage,
                              fontSize: textSizeLarge,
                              fontFamily: fontBold,
                              isLongText: true),
                        ),
                      ),
                      Container(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Column(
                            children: <Widget>[
                              quizCardSelection("A.", planetCard[x].option1,
                                  () {
                                removeCards(x);
                              }),
                              quizCardSelection("B.", planetCard[x].option2,
                                  () {
                                removeCards(x);
                              }),
                              quizCardSelection("C.", planetCard[x].option3,
                                  () {
                                removeCards(x);
                              }),
                              quizCardSelection("D.", planetCard[x].option4,
                                  () {
                                removeCards(x);
                              }),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
            child: GestureDetector(
              child: Container(
                decoration: boxDecoration(
                    radius: 20,
                    bgColor: appStore.isDarkModeOn ? cardDarkColor : white,
                    showShadow: true),
                child: Column(
                  children: <Widget>[
                    Container(
                        height: 200.0,
                        width: 320.0,
                        child: Container(
                          margin: const EdgeInsets.only(top: 50),
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                          child: text(planetCard[x].cardImage,
                              fontSize: textSizeLarge,
                              fontFamily: fontBold,
                              isLongText: true),
                        )),
                    Container(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(
                        children: <Widget>[
                          quizCardSelection("A.", planetCard[x].option1, () {
                            removeCards(x);
                          }),
                          quizCardSelection("B.", planetCard[x].option2, () {
                            removeCards(x);
                          }),
                          quizCardSelection("C.", planetCard[x].option3, () {
                            removeCards(x);
                          }),
                          quizCardSelection(
                            "D.",
                            planetCard[x].option4,
                            () {
                              removeCards(x);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return cardList;
  }
}

Widget quizCardSelection(var option, var option1, onPressed) {
  return InkWell(
    onTap: () {
      onPressed();
    },
    child: Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: boxDecoration(
        showShadow: false,
        bgColor: appStore.isDarkModeOn ? cardDarkColor : quiz_edit_background,
        radius: 10,
        color: quiz_view_color,
      ),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      width: 320,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: text(option1, textColor: quiz_textColorSecondary),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: text(option, textColor: quiz_textColorSecondary),
          )
        ],
      ),
    ),
  );
}
