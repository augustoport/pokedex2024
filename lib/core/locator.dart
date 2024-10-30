import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/core/service/dialog_service.dart';

GetIt locator = GetIt.instance;
EventBus eventBus = EventBus();

void setupLocator() {
  locator.registerLazySingleton(() => DialogService());
}
