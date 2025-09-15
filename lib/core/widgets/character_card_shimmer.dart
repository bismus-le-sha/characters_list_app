import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CharacterCardShimmer extends StatelessWidget {
  final double height;
  final double width;

  const CharacterCardShimmer({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(100),
              offset: Offset(5, 5),
              blurRadius: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class CardImageShimmer extends StatelessWidget {
  final double height;
  final double width;
  const CardImageShimmer({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: SizedBox.expand(child: const ColoredBox(color: Colors.white)),
    );
  }
}
