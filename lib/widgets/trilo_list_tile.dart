import 'package:flutter/material.dart';
import 'package:trilo_admin/constants/ui_constants.dart';

class TriloListTile extends StatelessWidget {
  const TriloListTile({
    super.key,
    this.leading,
    required this.titleText,
    this.subtitle,
    this.onTap,
  });

  final Widget? leading;
  final String titleText;
  final Widget? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      child: ListTile(
        dense: true,
        isThreeLine: false,
        contentPadding: EdgeInsets.symmetric(
          horizontal: leading != null ? Sizes.sm : Sizes.base,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: Corners.medBorder,
        ),
        tileColor: const Color.fromRGBO(241, 241, 241, 1),
        leading: leading,
        title: Text(
          titleText,
          style: theme.textTheme.titleMedium!.copyWith(
            fontSize: Sizes.base,
            // fontWeight: FontWeight.w400,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: subtitle,
        onTap: onTap,
      ),
    );
  }
}
