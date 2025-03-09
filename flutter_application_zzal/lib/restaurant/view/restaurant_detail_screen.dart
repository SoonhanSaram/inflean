import 'package:flutter/material.dart';
import 'package:flutter_application_zzal/common/layout/defalut_layout.dart';
import 'package:flutter_application_zzal/product/component/product_card.dart';
import 'package:flutter_application_zzal/rating/component/rating_card.dart';
import 'package:flutter_application_zzal/restaurant/component/restaurant_card.dart';
import 'package:flutter_application_zzal/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter_application_zzal/restaurant/model/restaurant_model.dart';
import 'package:flutter_application_zzal/restaurant/provider/restaurant_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const RestaurantDetailScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));

    if (state == null) {
      return const DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: '불타는 떡볶이',
      child: CustomScrollView(
        slivers: [
          renderTop(
            model: state,
          ),
          if (state is! RestaurantDetailModel) renderLoading(),
          if (state is RestaurantDetailModel) renderLable(),
          if (state is RestaurantDetailModel)
            renderProducts(products: state.products),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: RatingCard(
                avataImage: AssetImage('asset/img/logo/codefactory_logo.png'),
                images: [],
                rating: 4,
                email: 'jc@codefactory.ai',
                content: '여기는 시킬만 한 것 같네요',
              ),
            ),
          )
        ],
      ),
    );
  }
}

SliverPadding renderLoading() {
  return SliverPadding(
    padding: const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 16.0,
    ),
    sliver: SliverList(
      delegate: SliverChildListDelegate(
        List.generate(
          2,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SkeletonParagraph(
                style: const SkeletonParagraphStyle(
                    lines: 5, padding: EdgeInsets.zero)),
          ),
        ),
      ),
    ),
  );
}

SliverToBoxAdapter renderTop({
  required RestaurantModel model,
}) {
  return SliverToBoxAdapter(
    child: RestaurantCard.fromModel(
      model: model,
      isDetail: true,
    ),
  );
}

SliverPadding renderProducts({required List<RestaurantProductModel> products}) {
  return SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    sliver: SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final model = products[index];

          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ProductCard.fromModel(model: model),
          );
        },
        childCount: products.length,
      ),
    ),
  );
}

SliverPadding renderLable() {
  return const SliverPadding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    sliver: SliverToBoxAdapter(
      child: Text(
        '메뉴',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
