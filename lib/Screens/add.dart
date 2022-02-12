import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/Screens/dashboard.dart';
import 'package:elite/main.dart';
import 'package:elite/model/question.dart';
import 'package:elite/utils/AppWidget.dart';
import 'package:elite/utils/QuizColors.dart';
import 'package:elite/utils/QuizWidget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:elite/model/category.dart';

class Add extends StatefulWidget {
  static String tag = '/QuizDashboard';

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final Stream<QuerySnapshot> categories =
      FirebaseFirestore.instance.collection('categories').snapshots();

  List<Category> categoryList = [];
  List<Question> questionList = [];
  List<String> categoriList = [];
  String? selectedCategory = null;
  String? title = "";
  String? body = "";
  List<Map<String, dynamic>> question = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionList.add(Question());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: categories,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Expanded(
              child: Center(
                  child: CircularProgressIndicator(
                      color:
                          appStore.isDarkModeOn ? Colors.white : Colors.black)),
            );
          }

          categoriList.clear();
          categoryList = snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            Category category = Category(
              noa: data["noa"].toString(),
              categoryImgUrl: data["categoryImgUrl"].toString(),
              id: document.id.toString(),
              title: data["title"].toString(),
            );
            categoriList.add(data["title"].toString());
            return category;
          }).toList();
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    border: Border.all(
                      color: appStore.isDarkModeOn
                          ? cardDarkColor
                          : quiz_ShadowColor,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: appStore.isDarkModeOn
                              ? cardDarkColor
                              : quiz_ShadowColor,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 3.0)),
                    ],
                  ),
                  margin: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    onChanged: (text) {
                      title = text;
                    },
                    style: primaryTextStyle(),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
                      hintText: "Makale Başlığı",
                      border: InputBorder.none,
                      hintStyle: primaryTextStyle(),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    border: Border.all(
                      color: appStore.isDarkModeOn
                          ? cardDarkColor
                          : quiz_ShadowColor,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: appStore.isDarkModeOn
                              ? cardDarkColor
                              : quiz_ShadowColor,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 3.0)),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      hint: const Text("Kategori Seçiniz"),
                      isExpanded: true,
                      value: selectedCategory,
                      underline: Container(height: 0),
                      icon: const Icon(Icons.arrow_drop_down),
                      style: primaryTextStyle(),
                      onChanged: (String? newValue) {
                        setState(
                          () {
                            selectedCategory = newValue!;
                          },
                        );
                      },
                      items: categoriList.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      itemHeight: 50,
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: context.cardColor,
                      border: Border.all(
                        color: appStore.isDarkModeOn
                            ? cardDarkColor
                            : quiz_ShadowColor,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: appStore.isDarkModeOn
                                ? cardDarkColor
                                : quiz_ShadowColor,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 3.0)),
                      ],
                    ),
                    child: SizedBox(
                      height: 300,
                      child: TextFormField(
                        onChanged: (value) {
                          body = value;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: primaryTextStyle(),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(16, 22, 16, 22),
                          hintText: "Makale",
                          border: InputBorder.none,
                          hintStyle: primaryTextStyle(),
                        ),
                      ),
                    )),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: questionList.length,
                    itemBuilder: (context, item) {
                      return Container(
                        margin: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: context.cardColor,
                          border: Border.all(
                            color: appStore.isDarkModeOn
                                ? cardDarkColor
                                : quiz_ShadowColor,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: appStore.isDarkModeOn
                                    ? cardDarkColor
                                    : quiz_ShadowColor,
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(0, 3.0)),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                child: text("$item. Soru"),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                            TextFormField(
                              onChanged: (text) {
                                questionList[item].question = text;
                              },
                              style: primaryTextStyle(),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(16, 22, 16, 22),
                                hintText: "Soru",
                                border: InputBorder.none,
                                hintStyle: primaryTextStyle(),
                              ),
                            ),
                            quizDivider(),
                            questionAnswerRowA(item, "a"),
                            questionAnswerRowB(item, "b"),
                            questionAnswerRowC(item, "c"),
                            questionAnswerRowD(item, "d"),
                          ],
                        ),
                      );
                    }),
                Container(
                  margin: const EdgeInsets.all(12.0),
                  child: quizButtonAdd(
                    textContent: "Soru Ekle",
                    onPressed: () {
                      setState(
                        () {
                          print("object");
                          questionList.add(Question());
                        },
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12.0),
                  child: quizButton(
                    textContent: "Gönder",
                    onPressed: () {
                      CollectionReference reference = FirebaseFirestore.instance
                          .collection(
                              'categories/${categoryList.firstWhere((x) => x.title == selectedCategory).id}/articles');

                      var questionListMap = [];
                      questionList.forEach((element) {
                        questionListMap.add({
                          "question": element.question,
                          "answer": element.answer,
                          "a": element.a,
                          "b": element.b,
                          "c": element.c,
                          "d": element.d,
                        });
                      });
                      var data = {
                        "body": body,
                        "title": title,
                        "questions": questionListMap
                      };
                      reference.add(data);
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              actions: [],
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  Row questionAnswerRowA(int item, String value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: questionList[item].answer,
          onChanged: (value) {
            setState(() {
              questionList[item].answer = value.toString();
            });
          },
        ),
        Expanded(
          child: TextFormField(
            onChanged: (text) {
              questionList[item].a = text;
            },
            style: primaryTextStyle(),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
              hintText: "${value.toUpperCase()} Şıkkı",
              border: InputBorder.none,
              hintStyle: primaryTextStyle(),
            ),
          ),
        ),
      ],
    );
  }

  Row questionAnswerRowB(int item, String value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: questionList[item].answer,
          onChanged: (value) {
            setState(() {
              questionList[item].answer = value.toString();
            });
          },
        ),
        Expanded(
          child: TextFormField(
            onChanged: (text) {
              questionList[item].b = text;
            },
            style: primaryTextStyle(),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
              hintText: "${value.toUpperCase()} Şıkkı",
              border: InputBorder.none,
              hintStyle: primaryTextStyle(),
            ),
          ),
        ),
      ],
    );
  }

  Row questionAnswerRowC(int item, String value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: questionList[item].answer,
          onChanged: (value) {
            setState(() {
              questionList[item].answer = value.toString();
            });
          },
        ),
        Expanded(
          child: TextFormField(
            onChanged: (text) {
              questionList[item].c = text;
            },
            style: primaryTextStyle(),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
              hintText: "${value.toUpperCase()} Şıkkı",
              border: InputBorder.none,
              hintStyle: primaryTextStyle(),
            ),
          ),
        ),
      ],
    );
  }

  Row questionAnswerRowD(int item, String value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: questionList[item].answer,
          onChanged: (value) {
            setState(() {
              questionList[item].answer = value.toString();
            });
          },
        ),
        Expanded(
          child: TextFormField(
            onChanged: (text) {
              questionList[item].d = text;
            },
            style: primaryTextStyle(),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
              hintText: "${value.toUpperCase()} Şıkkı",
              border: InputBorder.none,
              hintStyle: primaryTextStyle(),
            ),
          ),
        ),
      ],
    );
  }
}
