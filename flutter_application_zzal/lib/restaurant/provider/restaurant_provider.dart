import 'package:flutter_application_zzal/common/model/cursor_pagination_model.dart';
import 'package:flutter_application_zzal/common/model/pagination_params.dart';
import 'package:flutter_application_zzal/common/provider/pagination_provider.dart';
import 'package:flutter_application_zzal/restaurant/model/restaurant_model.dart';
import 'package:flutter_application_zzal/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPaginationModel) {
    return null;
  }

  return state.data.firstWhere((e) => e.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(repository: repository);

    return notifier;
  },
);

class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  RestaurantStateNotifier({
    required super.repository,
  });

  void getDetail({
    required String id,
  }) async {
    if (state is! CursorPaginationModel) {
      await paginate();
    }

    if (state is! CursorPaginationModel) {
      return;
    }

    final pState = state as CursorPaginationModel;

    final response = await repository.getRestaurantDetail(id: id);

    state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>((e) => e.id == id ? response : e)
            .toList());
  }
}
