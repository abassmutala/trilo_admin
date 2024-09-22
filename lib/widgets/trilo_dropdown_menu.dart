import 'package:flutter/material.dart';
import 'package:trilo_admin/constants/app_colors.dart';
import 'package:trilo_admin/constants/ui_constants.dart';

class TriloDropdownMenu extends StatefulWidget {
  const TriloDropdownMenu(
      {super.key, this.focusNode, this.items, this.value, this.onChanged});
  final FocusNode? focusNode;
  final List<DropdownMenuItem<dynamic>>? items;
  final dynamic value;
  final ValueChanged? onChanged;

  @override
  State<TriloDropdownMenu> createState() => _TriloDropdownMenuState();
}

class _TriloDropdownMenuState extends State<TriloDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DropdownButtonFormField(
      items: widget.items,
      value: widget.value,
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
      style: theme.textTheme.titleLarge!.copyWith(
        overflow: TextOverflow.ellipsis,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: Sizes.xl,
          vertical: Sizes.med,
        ),
        filled: true,
        fillColor: AppColours.inputBgLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.base),
          borderSide: BorderSide.none,
        ),
        floatingLabelStyle:
            theme.textTheme.titleLarge!.copyWith(color: theme.hintColor),
        hintStyle: const TextStyle(color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      validator: (value) => value == "" ? "Please select an option" : null,
    );
  }
}
