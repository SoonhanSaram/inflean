import 'package:flutter/material.dart';
import 'package:flutter_application_zzal/restaurant/component/restaurant_card.dart';
import 'package:flutter_application_zzal/restaurant/provider/restaurant_provider.dart';
import 'package:flutter_application_zzal/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);

    if (data.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
          itemBuilder: (_, index) {
            final pitem = data[index];

            return GestureDetector(
                onTap: () {
                  print(pitem.id);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RestaurantDetailScreen(id: pitem.id),
                    ),
                  );
                },
                child: RestaurantCard.fromModel(model: pitem));
          },
          separatorBuilder: (_, index) {
            return const SizedBox(
              height: 16.0,
            );
          },
          itemCount: data.length),
    );
  }
}
