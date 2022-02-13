// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

History _$HistoryFromJson(Map<String, dynamic> json) => History(
      categoryId: json['categoryId'] as String,
      countCorrect: json['countCorrect'] as int,
      countRead: json['countRead'] as int,
      countTotal: json['countTotal'] as int,
    );

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'categoryId': instance.categoryId,
      'countRead': instance.countRead,
      'countCorrect': instance.countCorrect,
      'countTotal': instance.countTotal,
    };
