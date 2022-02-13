import 'package:get_it/get_it.dart';

import '../../repository/storage_repository.dart';
import '../../repository/auth_repository/auth_repository.dart';

GetIt locator = GetIt.instance;

void setupGetIt() {
  locator.registerLazySingleton(() => StorageRepository());
  locator.registerLazySingleton(() => AuthRepository());
}