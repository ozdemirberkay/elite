import 'package:elite/model/question.dart';

class Article {
  String? id;
  String? title;
  String? body;
  String? imgUrl;
  List<Question>? question;

  Article({
    this.id,
    this.title,
    this.body,
    this.imgUrl,
    this.question,
  });
}
