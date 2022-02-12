import 'package:elite/model/article.dart';

class Category {
  String id;
  List<Article> articles;

  Category({
    required this.id,
    required this.articles,
  });
}
