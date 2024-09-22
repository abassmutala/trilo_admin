import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:trilo_admin/constants/constants.dart';
import 'package:trilo_admin/constants/route_names.dart';
import 'package:trilo_admin/constants/ui_constants.dart';
import 'package:trilo_admin/locator.dart';
import 'package:trilo_admin/models/store.dart';
import 'package:trilo_admin/services/db.dart';
import 'package:trilo_admin/services/nav.dart';
import 'package:trilo_admin/utils/utilities.dart';
import 'package:trilo_admin/views/stores/map_view.dart';
import 'package:trilo_admin/widgets/detail_tile.dart';
import 'package:trilo_admin/widgets/phone_numbers.dart';

class StoreDetails extends StatefulWidget {
  final String uid;
  const StoreDetails(
    this.uid, {
    super.key,
  });

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  final NavigationService navService = locator<NavigationService>();
  final DatabaseService db = locator<DatabaseService>();
  final PageController controller = PageController();

  Future<Store> fetchStore() async => db.getStore(widget.uid);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FutureBuilder<Store>(
        future: db.getStore(widget.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          final Store store = snapshot.data!;
          return Hero(
            tag: widget.uid,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: ((context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        pinned: true,
                        stretch: true,
                        floating: true,
                        stretchTriggerOffset: 100,
                        elevation: 0.0,
                        // onStretchTrigger: () {},
                        expandedHeight: ScreenSize.width / 1.5,
                        centerTitle: true,
                        leading: IconButton(
                          onPressed: () => navService.pop(),
                          icon: Icon(
                            LucideIcons.chevronLeft,
                            color: theme.iconTheme.color,
                            // size: 32,
                          ),
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          background: store.photos!.isEmpty
                              ? Container(
                                  color: theme.colorScheme.secondary,
                                  child: Center(
                                    child: Text(
                                      Utilities.getInitials(store.name!),
                                      style: theme.textTheme.displayMedium!
                                          .copyWith(
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () => navService.navigateTo(
                                      imagePreviewRoute,
                                      arguments: widget.uid),
                                  child: PageView.builder(
                                    controller: controller,
                                    itemCount: store.photos!.length,
                                    itemBuilder: (context, index) => Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Stack(
                                          children: [
                                            storeImage(store, index),
                                            Container(
                                              color: Colors.black26,
                                            ),
                                          ],
                                        ),
                                        imageCountRatio(theme, store, index),
                                      ],
                                    ),
                                  ),
                                ),
                          // stretchModes: [
                          //   StretchMode.zoomBackground,
                          //   StretchMode.blurBackground,
                          //   StretchMode.fadeTitle
                          // ],
                          title: Text(
                            store.name!,
                            style: theme.textTheme.titleLarge!
                                .copyWith(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          titlePadding: const EdgeInsetsDirectional.only(
                            start: 56,
                            end: 64.0,
                            bottom: 16,
                          ),
                        ),
                      )
                    ]),
                body: ListView(
                  children: [
                    DetailTile(icon: LucideIcons.store, title: store.name!),
                    divider(),
                    DetailTile(icon: LucideIcons.star, title: store.category!),
                    divider(),
                    DetailTile(icon: LucideIcons.user2, title: store.owner!),
                    divider(),
                    Container(
                      width: ScreenSize.width,
                      // height: ScreenSize.width,
                      constraints: const BoxConstraints(
                        maxWidth: 360,
                        maxHeight: 360,
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: MapView(
                          latitude: store.coordinates!.latitude,
                          longitude: store.coordinates!.longitude,
                        ),
                      ),
                    ),
                    divider(),
                    DetailTile(
                      icon: LucideIcons.mapPin,
                      title: store.address!,
                      trailing: LucideIcons.arrowUpRight,
                      onTap: () {
                        navService.navigateTo(storeMapRoute, arguments: {
                          "storeName": store.name,
                          "storeAddress": store.address,
                          "coordinates": store.coordinates
                        });
                      },
                    ),
                    divider(),
                    phoneNumbersWidget(store.phone, theme),
                    DetailTile(
                        icon: LucideIcons.messageSquare, title: store.comment!),
                    divider(),
                    DetailTile(
                        icon: LucideIcons.clock,
                        title: DateTimeFormats.shortDateTime
                            .format(store.regDate!.toDate())),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget phoneNumbersWidget(List? phoneNumbers, ThemeData theme) {
    return PhoneNumbers(
      phoneNumbers: phoneNumbers,
    );
  }

  Widget divider() {
    return const Divider();
  }

  Widget storeImage(Store store, int index) {
    return CachedNetworkImage(
      progressIndicatorBuilder: (
        context,
        url,
        progress,
      ) =>
          const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      imageUrl: store.photos![index],
      errorWidget: (context, url, error) => const Icon(
        LucideIcons.imageOff,
        size: 100,
      ),
      fit: BoxFit.cover,
      width: ScreenSize.width,
    );
  }

  Widget imageCountRatio(ThemeData theme, Store store, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.xl),
        color: theme.canvasColor.withOpacity(0.5),
      ),
      padding: EdgeInsets.symmetric(horizontal: Sizes.med, vertical: Sizes.tny),
      margin: const EdgeInsetsDirectional.only(
        // start: 72,
        end: 16,
        bottom: 24,
      ),
      child: RichText(
        text: TextSpan(
          style: theme.textTheme.labelLarge,
          children: [
            TextSpan(
              text: "${store.photos!.indexOf(store.photos![index]) + 1}",
              style: TextStyle(color: theme.colorScheme.secondary),
            ),
            TextSpan(
              text: "/${store.photos!.length}",
              style: TextStyle(color: theme.colorScheme.onBackground),
            )
          ],
        ),
      ),
    );
  }
}
