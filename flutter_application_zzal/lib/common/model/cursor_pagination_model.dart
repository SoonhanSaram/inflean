import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

class CursorPaginationLoading extends CursorPaginationBase {}

//  genericArgument 를 받아서 T 을 설정하게 함함
@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPaginationModel<T> extends CursorPaginationBase {
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPaginationModel({
    required this.meta,
    required this.data,
  });

  CursorPaginationModel copyWith({
    CursorPaginationMeta? meta,
    List<T>? data,
  }) {
    return CursorPaginationModel(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }

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

  CursorPaginationMeta copyWith({
    int? count,
    bool? hasMore,
  }) {
    return CursorPaginationMeta(
      count: count ?? this.count,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}

//  새로고침 할 때
class CursorPaginationRefetching<T> extends CursorPaginationModel<T> {
  CursorPaginationRefetching({
    required super.meta,
    required super.data,
  });
}

// 리스트의 맨 아래로 내려서
//  추가 데이터를 요청하는 중
class CursorPaginationFetchingMore<T> extends CursorPaginationModel<T> {
  CursorPaginationFetchingMore({
    required super.meta,
    required super.data,
  });
}
