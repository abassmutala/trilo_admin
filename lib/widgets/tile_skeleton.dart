import 'package:flutter/material.dart';
import 'package:trilo_admin/constants/ui_constants.dart';
import 'package:trilo_admin/widgets/shimmer_effect.dart';

class TileSkeleton extends StatelessWidget {
  const TileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: Corners.medBorder,
      ),
      child: ShimmerEffect(color: Theme.of(context).colorScheme.surface),
    );
  }
}
