import 'package:elite/model/question.dart';

class Article {
  String id;
  String title;
  String body;
  String? imgUrl;
  List<Question> question;

  Article({
    required this.id,
    required this.title,
    required this.body,
    required this.imgUrl,
    required this.question,
  });
}
