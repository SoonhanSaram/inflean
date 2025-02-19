import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_zzal/common/const/data.dart';
import 'package:flutter_application_zzal/restaurant/component/dio/dio.dart';
import 'package:flutter_application_zzal/restaurant/component/restaurant_card.dart';
import 'package:flutter_application_zzal/restaurant/model/restaurant_model.dart';
import 'package:flutter_application_zzal/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_application_zzal/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> pagenateRestaurant() async {
    final dio = Dio();

    dio.interceptors.add(
      CustomInterceptor(
        storage: storage,
      ),
    );

    final response =
        await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
            .paginate();

    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List<RestaurantModel>>(
            future: pagenateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              print(snapshot.error);
              print(snapshot.data);

              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.separated(
                  itemBuilder: (_, index) {
                    final pitem = snapshot.data![index];

                    return GestureDetector(
                        onTap: () {
                          print(pitem.id);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  RestaurantDetailScreen(id: pitem.id),
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
                  itemCount: snapshot.data!.length);
            },
          ),
        ),
      ),
    );
  }
}
