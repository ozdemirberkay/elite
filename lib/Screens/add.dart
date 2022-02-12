import 'package:elite/Screens/dashboard.dart';
import 'package:elite/utils/AppWidget.dart';
import 'package:elite/utils/QuizConstant.dart';
import 'package:elite/utils/QuizWidget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class Add extends StatefulWidget {
  static String tag = '/QuizDashboard';

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(12.0),
            decoration: boxDecoration(
                bgColor: context.cardColor, showShadow: true, radius: 10),
            child: quizEditTextStyle("Makele Başlığı", isPassword: false),
          ),
          Container(
              margin: EdgeInsets.all(12.0),
              decoration: boxDecoration(
                  bgColor: context.cardColor, showShadow: true, radius: 10),
              child: SizedBox(
                height: 300,
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: primaryTextStyle(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(16, 22, 16, 22),
                    hintText: "Makale",
                    border: InputBorder.none,
                    hintStyle: primaryTextStyle(),
                  ),
                ),
              )),
          Container(
            margin: EdgeInsets.all(12.0),
            decoration: boxDecoration(
                bgColor: context.cardColor, showShadow: true, radius: 10),
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
            margin: EdgeInsets.all(24.0),
            child: quizButton(
              textContent: "quiz_lbl_continue",
              onPressed: () {
                setState(
                  () {
                    QuizDashboard().launch(context);
                  },
                );
              },
            ),
          ),
          Text("kategoryi seç"),
          Text("textfield makale"),
          Text("quiz sorısı alanı"),
          Text("quiz sorısı ekleme buttonu"),
          Text("gönder butonu"),
        ],
      ),
    );
  }
}
