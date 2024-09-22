import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:trilo_admin/constants/route_names.dart';
import 'package:trilo_admin/constants/ui_constants.dart';
import 'package:trilo_admin/locator.dart';
import 'package:trilo_admin/models/store.dart';
import 'package:trilo_admin/services/db.dart';
import 'package:trilo_admin/services/nav.dart';
import 'package:trilo_admin/widgets/api_list_builder.dart';
import 'package:trilo_admin/widgets/tile_skeleton.dart';
import 'package:trilo_admin/widgets/trilo_list_tile.dart';

class StoresList extends StatefulWidget {
  final String uid;
  const StoresList({super.key, required this.uid});

  @override
  State<StoresList> createState() => _StoresListState();
}

class _StoresListState extends State<StoresList> {
  late List<String>? storeIds = [];
  final NavigationService _nav = locator<NavigationService>();
  final DatabaseService _db = locator<DatabaseService>();

  Future<List<String>?> getStoreIds() async {
    final ids = await _db.getUserStoresIds(widget.uid);
    debugPrint("Stores: ${ids?.length}");
    return ids;
  }

  @override
  void initState() {
    super.initState();
    getStoreIds().then(
      (ids) => setState(() {
        storeIds = ids;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return StreamBuilder<List<Store>?>(
        stream: _db.getUserStores(storeIds),
        builder: (context, snapshot) {
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: ((context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      stretch: true,
                      expandedHeight: kToolbarHeight * 3,
                      stretchTriggerOffset: 100,
                      leading: IconButton(
                        icon: const Icon(LucideIcons.chevronLeft),
                        onPressed: () => _nav.pop(),
                      ),
                      centerTitle: true,
                      flexibleSpace: FlexibleSpaceBar(
                        stretchModes: const [StretchMode.zoomBackground],
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              "images/ericsson-mobility-report-novembe.png",
                              fit: BoxFit.cover,
                            ),
                            const ModalBarrier(
                              color: Colors.black45,
                            )
                          ],
                        ),
                        centerTitle: true,
                        titlePadding: EdgeInsetsDirectional.only(
                          start: 0,
                          bottom: Sizes.base,
                        ),
                        title: Text(
                          "${storeIds?.length} registered stores",
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: innerBoxIsScrolled
                                ? theme.appBarTheme.foregroundColor
                                : Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ]),
              body: APIListBuilder(
                  snapshot: snapshot,
                  separatorWidget: Spacing.verticalSpacingMed,
                  loadingWidget: ListView.separated(
                    shrinkWrap: true,
                    itemCount: 8,
                    padding: EdgeInsets.symmetric(horizontal: Sizes.base),
                    separatorBuilder: (context, index) =>
                        Spacing.verticalSpacingSm,
                    itemBuilder: (context, index) => const TileSkeleton(),
                  ),
                  nullIcon: LucideIcons.store,
                  nullLabel: "No shops found",
                  nullSubLabel: "You have not registered any shops yet",
                  itemBuilder: (context, store) {
                    return Hero(
                      tag: store.uid,
                      child: TriloListTile(
                        titleText: store.name!,
                        subtitle: Text(
                          store.address!,
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontSize: Sizes.med,
                            // fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () => _nav.navigateTo(
                          storeDetailsRoute,
                          arguments: store.uid,
                        ),
                      ),
                    );
                  }),
            ),
          );
        });
  }
}
