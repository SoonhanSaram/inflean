import 'package:flutter/material.dart';
import 'package:flutter_application_zzal/common/layout/defalut_layout.dart';
import 'package:flutter_application_zzal/product/component/product_card.dart';
import 'package:flutter_application_zzal/restaurant/component/restaurant_card.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String? title;

  const RestaurantDetailScreen({this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: CustomScrollView(
        slivers: [
          renderTop(),
          renderLable(),
          renderProducts(),
        ],
      ),
    );
  }

  SliverToBoxAdapter renderTop() {
    return SliverToBoxAdapter(
      child: RestaurantCard(
        image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
        name: '불타는 떡볶이',
        tags: const [
          '점츠',
          '테스트',
          '마스터',
        ],
        ratingsCount: 100,
        deliveryTime: 30,
        deliveryFee: 2000,
        ratings: 4.5,
        isDetail: true,
        detail: '불타는 떡볶이는 맛있는 떡볶이 입니다.',
      ),
    );
  }

  SliverPadding renderProducts() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ProductCard(),
            );
          },
          childCount: 10,
        ),
      ),
    );
  }

  SliverPadding renderLable() {
    return SliverPadding(
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
}
