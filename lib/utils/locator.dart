import 'package:crypto_pair_app/services/router_services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => RouterServices());
}
