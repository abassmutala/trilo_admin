import 'package:flutter/material.dart';
import 'package:trilo_admin/views/stores/map_view.dart';

class StoreMap extends StatelessWidget {
  const StoreMap({
    super.key,
    required this.coordinates,
    required this.storeName,
    required this.storeAddress,
  });

  final Map<String, dynamic> coordinates;
  final String storeName;
  final String storeAddress;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(storeName, style: theme.textTheme.titleMedium),
            Text(storeAddress, style: theme.textTheme.labelSmall!.copyWith(color: theme.hintColor),),
          ],
        ),
      ),
      body: MapView(
        latitude: coordinates['latitude'],
        longitude: coordinates['longitude'],
      ),
    );
  }
}
