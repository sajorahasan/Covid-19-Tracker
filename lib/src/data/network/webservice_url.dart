import 'package:covidtracker/env/config.dart';

class CovidURL {
  static String getData = Config.BASE_URL + "data.json";

  static String getStateData = Config.BASE_URL + "state_district_wise.json";
}
