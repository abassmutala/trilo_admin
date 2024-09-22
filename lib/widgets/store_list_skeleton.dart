import 'package:flutter/material.dart';
import 'package:trilo_admin/constants/ui_constants.dart';
import 'package:trilo_admin/widgets/shimmer_effect.dart';
import 'package:trilo_admin/widgets/tile_skeleton.dart';

class StoreListSkeleton extends StatelessWidget {
  const StoreListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      child: Column(
        children: [
          SizedBox(
            height: kToolbarHeight * 3,
            child: ShimmerEffect(color: theme.colorScheme.surface),
          ),
          Spacing.verticalSpacingMed,
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: Sizes.base),
            itemCount: 8,
            separatorBuilder: (context, index) => Spacing.verticalSpacingMed,
            itemBuilder: (context, index) => const TileSkeleton(),
          ),
        ],
      ),
    );
  }
}
