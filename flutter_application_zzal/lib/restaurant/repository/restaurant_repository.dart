import 'package:flutter_application_zzal/common/model/cursor_pagination_model.dart';
import 'package:flutter_application_zzal/restaurant/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_application_zzal/restaurant/model/restaurant_detail_model.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  //  http://$ip/restaurant

  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // generic 을 사용한 T 지정 방법
  // http://$ip/restaurant
  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPaginationModel<RestaurantModel>> paginate();

  // http://$ip/restaurant/{id}

  @GET('/{id}')
  @Headers({'accessToken': 'true'})
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
