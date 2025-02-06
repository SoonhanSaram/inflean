import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_zzal/common/const/data.dart';
import 'package:flutter_application_zzal/restaurant/component/restaurant._card.dart';
import 'package:flutter_application_zzal/restaurant/model/restaurant_model.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key});

  Future<List> pagenateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final response = await dio.get(
      'http://$ip/restaurant',
      options: Options(
        headers: {'authorization': 'Bearer $accessToken'},
      ),
    );

    return response.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List>(
            future: pagenateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              print(snapshot.error);
              print(snapshot.data);

              if (!snapshot.hasData) {
                return Container();
              }

              return ListView.separated(
                  itemBuilder: (_, index) {
                    final item = snapshot.data![index];

                    // parsed
                    final pitem = RestaurantModel(
                      id: item['id'],
                      name: item['name'],
                      thumbUrl: 'http://$ip${item['thumbUrl']}',
                      tags: List<String>.from(item['tags']),
                      priceRange: RestaurantPriceRange.values
                          .firstWhere((e) => e.name == item['priceRange']),
                      ratings: item['ratings'],
                      ratingsCount: item['ratingsCount'],
                      deliveryFee: item['deliveryFee'],
                      deliveryTime: item['deliveryTime'],
                    );
                    return RestaurantCard(
                        image: Image.network(
                          pitem.thumbUrl,
                          fit: BoxFit.cover,
                        ),
                        name: pitem.name,
                        tags: pitem.tags,
                        ratingsCount: pitem.ratingsCount,
                        deliveryTime: pitem.deliveryTime,
                        deliveryFee: pitem.deliveryFee,
                        ratings: pitem.ratings);
                  },
                  separatorBuilder: (_, index) {
                    return SizedBox(
                      height: 16.0,
                    );
                  },
                  itemCount: snapshot.data!.length);
            },
          ),
        ),
      ),
    );
  }
}
