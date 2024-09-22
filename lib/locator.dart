import 'package:get_it/get_it.dart';
import 'package:trilo_admin/services/auth.dart';
import 'package:trilo_admin/services/db.dart';
import 'package:trilo_admin/services/nav.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => DatabaseService());
  // locator.registerLazySingleton(() => LocationService());
  // locator.registerLazySingleton(() => ImageSelector());
  // locator.registerLazySingleton(() => PushNotificationService());
}
