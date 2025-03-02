import 'package:flutter_application_zzal/common/model/cursor_pagination_model.dart';
import 'package:flutter_application_zzal/common/model/pagination_params.dart';
import 'package:flutter_application_zzal/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final respository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(respository: respository);

    return notifier;
  },
);

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository respository;

  RestaurantStateNotifier({
    required this.respository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  void paginate({
    int fetchCount = 20,
    // 추가로 데이터 더 가져오기
    // true - 추가로 데이터 더 가져옴
    // false - 새로고침 (현재 상태를 덮어씌움)
    bool fetchMore = false,
    // 강제로 다시 로딩하기
    // true - CursorPaginationLoading()
    bool forceRefetch = false,
  }) async {
    try {
      // 다섯가지 가능성
      // state의 상태
      // 1) CursorPagination - 정상적으로 데이터가 있는 상태

      // 2) CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음)
      // 3) CursorPaginationError - 에러가 있는 상태
      // 4) CursorPaginationRefetching - 첫번 째 페이지부터 다시 데이터를 가져올 때,

      // 바로 반환하는 상황
      // 1) hasMore = false (기존 상태에서 이미 다음 데이터가 없다는 값을 들고 있다면)
      if (state is CursorPaginationModel && !forceRefetch) {
        final pState = state as CursorPaginationModel;

        if (!pState.meta.hasMore) {
          return;
        }
      }

      // 2) 로딩중 - fetchMore = true
      //            fetchMore가 아닐 때 - 새로고침의 의도가 있다.
      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      // PaginationParams 생성

      PaginationParams paginationParams = PaginationParams(count: fetchCount);

      // 5) CursorPaginationfetchMore - 추가 데이터를 pagianate 해오라는 요청을 받았을 때,
      if (fetchMore) {
        final pState = state as CursorPaginationModel;

        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      } else {
        if (state is CursorPaginationModel && !forceRefetch) {
          //  만약에 데이터가 있는 상황이라면
          //  기존 데이터를 보존한채로 Fetch를 진행
          final pState = state as CursorPaginationModel;
          state =
              CursorPaginationRefetching(meta: pState.meta, data: pState.data);
        } else {
          state = CursorPaginationLoading();
        }
      }

      final response = await respository.paginate(
        paginationParams: paginationParams,
      );
      // 데이터를 처음부터 가져오는 상황

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;

        state = response.copyWith(
          data: [
            ...pState.data,
            ...response.data,
          ],
        );
      } else {
        state = response;
      }
    } catch (e) {
      state = CursorPaginationError(
        message: '데이터를 가져오지 못했습니다.',
      );
    }
  }
}
