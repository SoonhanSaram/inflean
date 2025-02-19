import 'package:flutter_application_zzal/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

//  genericArgument 를 받아서 T 을 설정하게 함함
@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPaginationModel<T> {
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPaginationModel({
    required this.meta,
    required this.data,
  });
// T 을 사용하기 위해 변경경
  factory CursorPaginationModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationModelFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}
