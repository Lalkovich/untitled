import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:untitled/domain/model/day.dart';
import 'package:untitled/domain/repository/day_repository.dart';

part 'home_state.g.dart';

class HomeState = HomeStateBase with _$HomeState;

abstract class HomeStateBase with Store {
  HomeStateBase();

  @observable
  Day? day;

  @observable
  bool isLoading = false;

  @action
  Future<void> getDay({
    required double latitude,
    required double longitude,
  }) async {
    isLoading = true;
    final DayRepository dayRepository = GetIt.instance<DayRepository>();
    final data = await dayRepository.getDay(latitude: latitude, longitude: longitude);
    day = data;
    isLoading = false;
  }
}