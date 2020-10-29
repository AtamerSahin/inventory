import 'package:get_it/get_it.dart';
import 'package:inventory/repository/ebatli_repository.dart';
import 'package:inventory/view_models/ebatli_view_models.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => EbatliRepository());
  locator.registerLazySingleton(() => EbatliViewModel());
}
