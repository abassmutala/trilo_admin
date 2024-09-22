import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:trilo_admin/constants/ui_constants.dart';
import 'package:trilo_admin/widgets/empty_state_widget.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class APIListBuilder<T> extends StatelessWidget {
  const APIListBuilder({
    super.key,
    required this.snapshot,
    required this.itemBuilder,
    this.nullIcon,
    this.errorIcon = LucideIcons.alertTriangle,
    this.nullLabel,
    this.errorTitle,
    this.nullSubLabel,
    this.errorSubtitle,
    this.referralButtonTitle,
    this.referralAction,
    this.separatorWidget = const SizedBox(
      height: 4.0,
    ),
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.physics,
    this.loadingWidget,
  });
  final AsyncSnapshot<List<T>?> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;
  final IconData? nullIcon;
  final IconData errorIcon;
  final String? nullLabel;
  final String? errorTitle;
  final String? nullSubLabel;
  final String? errorSubtitle;
  final String? referralButtonTitle;
  final GestureTapCallback? referralAction;
  final Widget separatorWidget;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return loadingWidget ??
          const Center(child: CircularProgressIndicator.adaptive());
    }
    if (snapshot.hasError) {
      debugPrint(snapshot.error.toString());
      return EmptyStateLayout(
        nullIcon: errorIcon,
        nullLabel: errorTitle,
        nullSubLabel: errorSubtitle,
      );
    }
    // if (snapshot.hasData) {
    final List<T>? items = snapshot.data;
    if (items!.isEmpty) {
      return Material(
        // width: ScreenSize.width,
        // color: theme.colorScheme.background,
        child: EmptyStateLayout(
          nullIcon: nullIcon,
          nullLabel: nullLabel,
          nullSubLabel: nullSubLabel,
          referralAction: referralAction,
          referralButtonLabel: referralButtonTitle,
        ),
      );
    }
    return _buildList(items);
    // }
    // return const Center(
    //   child: CircularProgressIndicator.adaptive(),
    // );
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
      key: PageStorageKey<String>(items.toString()),
      physics: physics,
      padding: padding ??
          EdgeInsets.symmetric(vertical: Sizes.med, horizontal: Sizes.base),
      scrollDirection: scrollDirection,
      shrinkWrap: true,
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
      separatorBuilder: (context, index) => separatorWidget,
      itemCount: items.length,
    );
  }
}




              

              // if (snapshot.connectionState == ConnectionState.done) {
              //   Map<String, dynamic> data =
              //       snapshot.data!.data() as Map<String, dynamic>;
              //   final _host = CarHost.fromMap(data);
              //   return ListTile();
              // }

              // return const CircularProgressIndicator.adaptive();