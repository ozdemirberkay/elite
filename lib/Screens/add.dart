import 'package:elite/Screens/dashboard.dart';
import 'package:elite/main.dart';
import 'package:elite/utils/AppWidget.dart';
import 'package:elite/utils/QuizColors.dart';
import 'package:elite/utils/QuizWidget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class Add extends StatefulWidget {
  static String tag = '/QuizDashboard';

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  List<String> categoriList = ["Kategori Seç", "Art", "Sience"];
  String selectedCategory = "Kategori Seç";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.cardColor,
              border: Border.all(
                color: appStore.isDarkModeOn ? cardDarkColor : quiz_ShadowColor,
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
            child: quizEditTextStyle("Makele Başlığı", isPassword: false),
          ),
          Container(
            margin: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: context.cardColor,
              border: Border.all(
                color: appStore.isDarkModeOn ? cardDarkColor : quiz_ShadowColor,
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
                isExpanded: true,
                value: selectedCategory,
                underline: Container(height: 0),
                icon: Icon(Icons.arrow_drop_down),
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
                  color:
                      appStore.isDarkModeOn ? cardDarkColor : quiz_ShadowColor,
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
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: primaryTextStyle(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
                    hintText: "Makale",
                    border: InputBorder.none,
                    hintStyle: primaryTextStyle(),
                  ),
                ),
              )),
          Container(
            margin: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: context.cardColor,
              border: Border.all(
                color: appStore.isDarkModeOn ? cardDarkColor : quiz_ShadowColor,
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
                    child: text("1. Soru"),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                quizEditTextStyle("Soru", isPassword: false),
                quizDivider(),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: 1,
                      onChanged: (value) {
                        print(value.toString());
                      },
                    ),
                    Expanded(
                        child: quizEditTextStyle("A şıkkı", isPassword: false)),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: 1,
                      onChanged: (value) {
                        print(value.toString());
                      },
                    ),
                    Expanded(
                        child: quizEditTextStyle("A şıkkı", isPassword: false)),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: 1,
                      onChanged: (value) {
                        print(value.toString());
                      },
                    ),
                    Expanded(
                        child: quizEditTextStyle("A şıkkı", isPassword: false)),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 4,
                      groupValue: 1,
                      onChanged: (value) {
                        print(value.toString());
                      },
                    ),
                    Expanded(
                        child: quizEditTextStyle("A şıkkı", isPassword: false)),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(12.0),
            child: quizButtonAdd(
              textContent: "Soru Ekle",
              onPressed: () {
                setState(
                  () {
                    QuizDashboard().launch(context);
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
                setState(
                  () {
                    QuizDashboard().launch(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
