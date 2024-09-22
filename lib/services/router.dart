import 'package:flutter/material.dart';
import 'package:trilo_admin/constants/route_names.dart';
import 'package:trilo_admin/views/auth/profile.dart';
import 'package:trilo_admin/views/auth/welcome.dart';
import 'package:trilo_admin/views/stores/image_preview.dart';
import 'package:trilo_admin/views/stores/store_details.dart';
import 'package:trilo_admin/views/stores/store_map.dart';
import 'package:trilo_admin/views/stores/stores_list.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case storesListRoute:
      final String uid = settings.arguments as String;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: StoresList(uid: uid),
      );
    case storeDetailsRoute:
      final String uid = settings.arguments as String;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: StoreDetails(uid),
      );
    // case signUpViewRoute:
    //   return _getPageRoute(
    //     routeName: settings.name!,
    //     viewToShow: const SignUp(),
    //   );
    case profileViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Profile(),
      );
    case welcomeViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const Welcome(),
      );
    case storeMapRoute:
      final Map<String, dynamic> storeMapArgs =
          settings.arguments as Map<String, dynamic>;
      // final String storeName = settings.arguments as String;
      // final String storeAddress = settings.arguments as String;
      // final Map<String, dynamic> coordinates =
      //     settings.arguments as Map<String, dynamic>;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: StoreMap(
          storeName: storeMapArgs['storeName'],
          storeAddress: storeMapArgs['storeAddress'],
          coordinates: {
            "latitude": storeMapArgs['coordinates'].latitude,
            "longitude": storeMapArgs['coordinates'].longitude
          },
        ),
      );
    case imagePreviewRoute:
      final String uid = settings.arguments as String;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ImagePreview(uid),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute(
    {required String routeName, required Widget viewToShow}) {
  return MaterialPageRoute(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow,
  );
}

// Route<dynamic> _errorRoute() {
//   return MaterialPageRoute(
//     builder: (_) => Scaffold(
//       appBar: AppBar(
//         title: const Text(''),
//       ),
//       body: const Center(
//         child: Text('ERROR'),
//       ),
//     ),
//   );
// }
