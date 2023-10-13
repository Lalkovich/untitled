import '../../domain/model/day.dart';
import '../api/model/api_day.dart';

class DayMapper {
  static Day fromApi(ApiDay day) {
    return Day(
      sunrise: DateTime.tryParse(day.sunrise),
      sunset: DateTime.tryParse(day.sunset),
      solarNoon: DateTime.tryParse(day.solarNoon),
      dayLength: day.dayLength.toInt(),
    );
  }
}