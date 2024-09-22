import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trilo_admin/constants/route_names.dart';
import 'package:trilo_admin/constants/ui_constants.dart';
import 'package:trilo_admin/locator.dart';
import 'package:trilo_admin/models/store.dart';
import 'package:trilo_admin/services/db.dart';
import 'package:trilo_admin/services/nav.dart';
import 'package:trilo_admin/widgets/api_list_builder.dart';
import 'package:trilo_admin/widgets/tile_skeleton.dart';
import 'package:trilo_admin/widgets/trilo_list_tile.dart';

class ViewStores extends StatefulWidget {
  const ViewStores({super.key});

  @override
  State<ViewStores> createState() => _StoresListState();
}

class _StoresListState extends State<ViewStores>
    with SingleTickerProviderStateMixin {
  final NavigationService _nav = locator<NavigationService>();
  final DatabaseService _db = locator<DatabaseService>();
  GoogleMapController? mapController;
  late TabController _tabController;
  Set<Marker> markers = {};

  Future<List<Store>?> fetchStores() async {
    List<Store>? stores = await _db.fetchStores();
    return stores;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    fetchStores().then((stores) => setState(() {
          markers = stores!.map((store) {
            return Marker(
              markerId: MarkerId(store.uid),
              position: LatLng(
                store.coordinates!.latitude,
                store.coordinates!.longitude,
              ),
              infoWindow: InfoWindow(
                title: store.name,
                onTap: () =>
                    _nav.navigateTo(storeDetailsRoute, arguments: store.uid),
              ),
            );
          }).toSet();
        }));
    // fetchAndSetMarkers();
  }

  final List<Map<String, dynamic>> tabs = [
    {"name": "List", "icon": Icons.list_outlined},
    {"name": "Map", "icon": Icons.map_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return FutureBuilder<List<Store>?>(
        future: fetchStores(),
        builder: (context, snapshot) {
          return DefaultTabController(
            length: tabs.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "${snapshot.data?.length} registered stores",
                  style: theme.textTheme.titleLarge!.copyWith(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                bottom: TabBar(
                  controller: _tabController,
                  tabs: tabs
                      .map(
                        (tab) => Tab(
                          text: tab["name"],
                          icon: Icon(tab["icon"]),
                        ),
                      )
                      .toList(),
                ),
              ),
              body: TabBarView(
                  controller: _tabController,
                  children: [listView(snapshot, theme), mapView()]),
            ),
          );
        });
  }

  GoogleMap mapView() {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(5.6851566, -0.0298422),
        zoom: 13,
      ),
      markers: markers,
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
    );
  }

  APIListBuilder<Store> listView(
      AsyncSnapshot<List<Store>?> snapshot, ThemeData theme) {
    return APIListBuilder(
        snapshot: snapshot,
        separatorWidget: Spacing.verticalSpacingMed,
        loadingWidget: ListView.separated(
          shrinkWrap: true,
          itemCount: 8,
          padding: EdgeInsets.symmetric(horizontal: Sizes.base),
          separatorBuilder: (context, index) => Spacing.verticalSpacingSm,
          itemBuilder: (context, index) => const TileSkeleton(),
        ),
        nullIcon: Icons.store_outlined,
        nullLabel: "No shops found",
        nullSubLabel: "No shops have been registered yet",
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
        });
  }
}
