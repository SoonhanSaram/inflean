import 'package:flutter_application_zzal/common/const/data.dart';
import 'package:flutter_application_zzal/common/dio/dio.dart';
import 'package:flutter_application_zzal/common/model/cursor_pagination_model.dart';
import 'package:flutter_application_zzal/common/model/pagination_params.dart';
import 'package:flutter_application_zzal/common/repository/base_pagination_repository.dart';
import 'package:flutter_application_zzal/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_application_zzal/restaurant/model/restaurant_detail_model.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final respository =
      RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

  return respository;
});

@RestApi()
abstract class RestaurantRepository
    implements IBasePaginationRepository<RestaurantModel> {
  //  http://$ip/restaurant

  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // generic 을 사용한 T 지정 방법
  // http://$ip/restaurant
  @override
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPaginationModel<RestaurantModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  // http://$ip/restaurant/{id}

  @GET('/{id}')
  @Headers({'accessToken': 'true'})
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
