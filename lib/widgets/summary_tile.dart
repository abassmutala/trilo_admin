import 'package:flutter/material.dart';
import 'package:trilo_admin/constants/ui_constants.dart';

class SummaryTile extends StatelessWidget {
  const SummaryTile({
    super.key,
    required this.name,
    required this.value,
    this.onTap,
  });
  final String name;
  final int value;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      elevation: 0.0,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(Sizes.med),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: theme.textTheme.headlineSmall,
              ),
              Spacing.verticalSpacingMed,
              Text(
                value.toString(),
                style: theme.textTheme.headlineLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "80% increment from last week",
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: theme.colorScheme.outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
