import 'package:untitled/data/api/request/get_day_body.dart';
import 'package:untitled/data/api/service/sunrise_service.dart';

import '../../domain/model/day.dart';
import '../mapper/day_mapper.dart';

class ApiUtil {
  final SunriseService _sunriseService;

  ApiUtil(this._sunriseService);

  Future<Day> getDay({
    required double latitude,
    required double longitude,
  }) async {
    final body = GetDayBody(latitude: latitude, longitude: longitude);
    final result = await _sunriseService.getDay(body);
    return DayMapper.fromApi(result);
  }
}