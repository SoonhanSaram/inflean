// 데이터의 정의를 확실하게 함으로 오작동을 방지하기 위함
import 'package:flutter/material.dart';
import 'package:flutter_application_zzal/common/const/data.dart';

enum RestaurantPriceRange { expensive, medium, cheap }

class RestaurantModel {
  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryFee;
  final int deliveryTime;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryFee,
    required this.deliveryTime,
  });

  factory RestaurantModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: 'http://$ip${json['thumbUrl']}',
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values
          .firstWhere((e) => e.name == json['priceRange']),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryFee: json['deliveryFee'],
      deliveryTime: json['deliveryTime'],
    );
  }
}
