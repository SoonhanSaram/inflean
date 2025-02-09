import 'package:flutter/material.dart';
import 'package:flutter_application_zzal/common/const/colors.dart';

class RestaurantCard extends StatelessWidget {
  // 이미지
  final Widget image;
  // 레스토랑 이름
  final String name;

  // 레스토랑 태그
  final List<String> tags;

  // 평점개수
  final int ratingsCount;

  // 배송 시간
  final int deliveryTime;

  // 배송 요금
  final int deliveryFee;

  // 평균 평점
  final double ratings;

  const RestaurantCard(
      {
      // 이미지
      required this.image,
      // 레스토랑 이름
      required this.name,
      // 레스토랑 태그
      required this.tags,
      // 평점개수
      required this.ratingsCount,
      // 배송 시간
      required this.deliveryTime,
      // 배송 요금
      required this.deliveryFee,
      // 평균 평점
      required this.ratings,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: image,
        ),
        const SizedBox(height: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              tags.join(' · '),
              style: const TextStyle(
                color: BODY_TEXT_COLOR,
                fontSize: 14.0,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                _IconText(
                  icon: Icons.star,
                  label: ratings.toString(),
                ),
                renderDot(),
                _IconText(
                  icon: Icons.receipt,
                  label: ratingsCount.toString(),
                ),
                renderDot(),
                _IconText(
                  icon: Icons.timelapse_outlined,
                  label: '$deliveryTime분',
                ),
                renderDot(),
                _IconText(
                  icon: Icons.monetization_on,
                  label:
                      '${deliveryFee == 0 ? '무료' : deliveryFee.toString()}원',
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        '·',
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;
  const _IconText({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: PRIMARY_COLOR, size: 14.0),
        const SizedBox(width: 8.0),
        Text(label,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ))
      ],
    );
  }
}
