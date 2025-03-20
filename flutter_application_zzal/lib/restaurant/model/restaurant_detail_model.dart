import 'package:flutter_application_zzal/common/utils/data_utils.dart';
import 'package:flutter_application_zzal/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_detail_model.g.dart';

// "detail": "오늘 주문하면 배송비 3000원 할인!",
@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryFee,
    required super.deliveryTime,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RestaurantDetailModelToJson(this);

  // factory RestaurantDetailModel.fromJson({required Map<String, dynamic> json}) {
  //   return RestaurantDetailModel(
  //     id: json['id'],
  //     name: json['name'],
  //     thumbUrl: 'http://$ip${json['thumbUrl']}',
  //     tags: List<String>.from(json['tags']),
  //     priceRange: RestaurantPriceRange.values
  //         .firstWhere((e) => e.name == json['priceRange']),
  //     ratings: json['ratings'],
  //     ratingsCount: json['ratingsCount'],
  //     deliveryFee: json['deliveryFee'],
  //     deliveryTime: json['deliveryTime'],
  //     detail: json['detail'],
  //     products: json['products']
  //         .map<RestaurantProductModel>(
  //           (e) => RestaurantProductModel.fromJson(json: e),
  //         )
  //         .toList(),
  //   );
  // }
}

// "products": [
//     {
//       "id": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
//       "name": "마라맛 코팩 떡볶이",
//       "imgUrl": "/img/img.png",
//       "detail": "서울에서 두번째로 맛있는 떡볶이집! 리뷰 이벤트 진행중~",
//       "price": 8000
//     }
//   ]

@JsonSerializable()
class RestaurantProductModel {
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.detail,
      required this.price});

  factory RestaurantProductModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantProductModelFromJson(json);

  // factory RestaurantProductModel.fromJson(
  //     {required Map<String, dynamic> json}) {
  //   return RestaurantProductModel(
  //     id: json['is'],
  //     name: json['name'],
  //     imgUrl: 'http://$ip${json['imgUrl']}',
  //     detail: json['detail'],
  //     price: json['price'],
  //   );
  // }
}




// RestaurantModel 을 extends 하지 않는 방법 
// class RestaurantDetailModel {
//   final RestaurantModel restaurantModel;
//   final String id;
//   final String name;
//   final String imgUrl;
//   final String productDetail;
//   final int price;

//   RestaurantDetailModel({
//     required this.restaurantModel,
//     required this.id,
//     required this.name,
//     required this.imgUrl,
//     required this.productDetail,
//     required this.price,
//   });

//   factory RestaurantDetailModel.fromJson({required Map<String, dynamic> json}) {
//     return RestaurantDetailModel(
//       restaurantModel: RestaurantModel.fromJson(json: json),
//       id: json['product']['id'],
//       name: json['product']['name'],
//       imgUrl: 'http://$ip${json['product']['imgUrl']}',
//       productDetail: json['product']['detail'],
//       price: json['product']['price'],
//     );
//   }
// }
