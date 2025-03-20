import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_application_zzal/common/const/data.dart';
import 'package:flutter_application_zzal/common/dio/dio.dart';
import 'package:flutter_application_zzal/common/model/cursor_pagination_model.dart';
import 'package:flutter_application_zzal/common/model/pagination_params.dart';
import 'package:flutter_application_zzal/common/repository/base_pagination_repository.dart';
import 'package:flutter_application_zzal/rating/model/rating_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part "restaurant_rating_repository.g.dart";

final restaurantRatingRepositoryProvider =
    Provider.family<RestaurantRatingRepository, String>((ref, id) {
  final dio = ref.watch(dioProvider);

  return RestaurantRatingRepository(dio,
      baseUrl: "http://$ip/restaurant/$id/rating");
});

// http://ip/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRepository
    implements IBasePaginationRepository<RatingModel> {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @override
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPaginationModel<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
