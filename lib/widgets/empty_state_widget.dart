import 'package:flutter/material.dart';
import '/constants/ui_constants.dart';

class EmptyStateLayout extends StatelessWidget {
  final IconData? nullIcon;
  final Color? iconColor;
  final String? nullLabel;
  final String? nullSubLabel;
  final GestureTapCallback? referralAction;
  final String? referralButtonLabel;

  const EmptyStateLayout({
    super.key,
    required this.nullIcon,
    this.iconColor,
    this.nullLabel,
    this.nullSubLabel,
    this.referralAction,
    this.referralButtonLabel,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Material(
        type: MaterialType.canvas,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacing.verticalSpacingXl,
            Icon(
              nullIcon,
              size: 100.0,
              color: iconColor ?? theme.colorScheme.outline,
            ),
            Spacing.verticalSpacingMed,
            if (nullLabel != null)
              Padding(
                padding: EdgeInsets.symmetric(vertical: Sizes.tny),
                child: Text(
                  nullLabel!,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            if (nullSubLabel != null)
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Sizes.sm, horizontal: Sizes.base),
                child: Text(
                  nullSubLabel!,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            if (referralAction != null)
              Padding(
                padding: EdgeInsets.symmetric(
                        vertical: Sizes.sm, horizontal: Sizes.base)
                    .add(const EdgeInsets.symmetric(horizontal: 48.0)),
                child: SizedBox(
                  child: OutlinedButton(
                    onPressed: referralAction!,
                    child: Text(referralButtonLabel!),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
