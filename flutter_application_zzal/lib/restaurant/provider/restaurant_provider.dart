import 'package:flutter_application_zzal/common/model/cursor_pagination_model.dart';
import 'package:flutter_application_zzal/restaurant/model/restaurant_model.dart';
import 'package:flutter_application_zzal/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, List<RestaurantModel>>(
  (ref) {
    final respository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(respository: respository);

    return notifier;
  },
);

class RestaurantStateNotifier extends StateNotifier<CursorPaginationModel> {
  final RestaurantRepository respository;

  RestaurantStateNotifier({
    required this.respository,
  }) : super([]) {
    paginate();
  }

  paginate() async {
    final response = await respository.paginate();

    state = [...state, ...response.data];
  }
}
