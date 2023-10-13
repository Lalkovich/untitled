import 'package:get_it/get_it.dart';
import 'package:untitled/data/api/api_util.dart';
import 'package:untitled/data/api/service/sunrise_service.dart';
import 'package:untitled/data/repository/day_data_repository.dart';
import 'package:untitled/domain/repository/day_repository.dart';
import 'package:untitled/presentation/home/home_state.dart';

final locator = GetIt.instance;

void setup(){
  locator.registerLazySingleton<ApiUtil>(() => ApiUtil(SunriseService()));
  locator.registerLazySingleton<DayRepository>(() => DayDataRepository(locator<ApiUtil>()));
  locator.registerLazySingleton<HomeState>(() => HomeState());
}