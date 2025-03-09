import 'package:flutter/material.dart';
import 'package:flutter_application_zzal/common/const/colors.dart';
import 'package:collection/collection.dart';

class RatingCard extends StatelessWidget {
  // networkImage
  // assetImage

  // CircleAvatar
  final ImageProvider avataImage;
  // 리스트로 위젯 이미지를 보여줄 때,
  final List<Image> images;
  final int rating;
  final String email;
  final String content;

  const RatingCard(
      { // CircleAvatar
      required this.avataImage,
      required this.images,
      required this.rating,
      required this.email,
      required this.content,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          avataImage: avataImage,
          rating: rating,
          email: email,
        ),
        const SizedBox(height: 16.0),
        _Body(
          content: content,
        ),
        if (images.isNotEmpty)
          SizedBox(
            height: 100.0,
            child: _Images(
              images: images,
            ),
          ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  // CircleAvatar
  final ImageProvider avataImage;
  final int rating;
  final String email;
  const _Header({
    required this.avataImage,
    required this.rating,
    required this.email,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: avataImage,
          radius: 12.0,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
        ),
        ...List.generate(
          5,
          (index) => Icon(
            index < rating ? Icons.star : Icons.star_border_outlined,
            color: Colors.yellow[600],
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;
  const _Body({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Row 에 Flexible 을 넣으면 화면이 깨지지 않고 화면에 꽉차게 줄 넘어감
    return Row(
      children: [
        Flexible(
          child: Text(
            content,
            style: const TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
          ),
        )
      ],
    );
  }
}

class _Images extends StatelessWidget {
  final List<Image> images;
  const _Images({
    required this.images,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      // 다섯개 이상의 사진은 들어갈 수 없음
      children: images
          .mapIndexed(
            (index, e) => Padding(
              padding:
                  EdgeInsets.only(right: index == images.length - 1 ? 0 : 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: e,
              ),
            ),
          )
          .toList(),
    );
  }
}
