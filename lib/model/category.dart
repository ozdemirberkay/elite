import 'package:elite/model/article.dart';

class Category {
  String id;
  String? categoryImgUrl;
  String title;

  List<Article>? articles;

  Category({
    required this.id,
    this.categoryImgUrl,
    required this.title,
    this.articles,
  });
}
