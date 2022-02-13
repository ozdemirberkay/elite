import 'package:json_annotation/json_annotation.dart';

part 'history.g.dart';

@JsonSerializable()
class History {
  String categoryId;
  int countRead;
  int countCorrect;
  int countTotal;

  History({
    required this.categoryId,
    required this.countCorrect,
    required this.countRead,
    required this.countTotal,
  });

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);

  /// Connect the generated [_$HistoryToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$HistoryToJson(this);
}
