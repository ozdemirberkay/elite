import 'package:elite/Screens/add.dart';
import 'package:elite/Screens/article_details.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:elite/Screens/kategoriler.dart';
import 'package:elite/Screens/scores.dart';
import 'package:elite/utils/QuizColors.dart';

import '../main.dart';

class QuizDashboard extends StatefulWidget {
  static String tag = '/QuizDashboard';

  @override
  _QuizDashboardState createState() => _QuizDashboardState();
}

class _QuizDashboardState extends State<QuizDashboard> {
  var selectedIndex = 0;

  var pages = [
    Categories(),
    Add(),
    Scores(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  void _onItemTapped(int index) {
    setState(
      () {
        selectedIndex = index;
        if (selectedIndex == 0) {
        } else if (selectedIndex == 1) {
        } else if (selectedIndex == 2) {}
      },
    );
  }

  Widget quizItem(var pos, var icon, var title) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            color: selectedIndex == pos ? quiz_colorPrimary : quiz_icon_color,
          ),
          Text(title,
              style: primaryTextStyle(
                  color: selectedIndex == pos
                      ? quiz_colorPrimary
                      : quiz_icon_color))
        ],
      ),
    ).onTap(
      () {
        setState(
          () {
            _onItemTapped(pos);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cardColor,
      body: SafeArea(child: pages[selectedIndex]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: context.cardColor,
          border: Border.all(
            color: appStore.isDarkModeOn ? cardDarkColor : quiz_ShadowColor,
          ),
          borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: appStore.isDarkModeOn ? cardDarkColor : quiz_ShadowColor,
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 3.0)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              quizItem(0, Icons.home_outlined, "Kategoriler"),
              quizItem(1, Icons.add_circle_outline, "Ekle"),
              quizItem(2, Icons.bar_chart, "Skorlar"),
            ],
          ),
        ),
      ),
    );
  }
}
