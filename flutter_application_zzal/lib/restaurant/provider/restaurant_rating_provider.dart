import 'package:flutter_application_zzal/common/provider/pagination_provider.dart';
import 'package:flutter_application_zzal/rating/model/rating_model.dart';
import 'package:flutter_application_zzal/restaurant/repository/restaurant_rating_repository.dart';

class RestaurantRatingStateNotifier
    extends PaginationProvider<RatingModel, RestaurantRatingRepository> {
  RestaurantRatingStateNotifier({
    required super.repository,
  });
}
