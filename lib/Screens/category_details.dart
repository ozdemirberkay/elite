import 'package:flutter/material.dart';

class CategoryDetails extends StatefulWidget {
  final String id;
  CategoryDetails({Key? key, required this.id}) : super(key: key);

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}
