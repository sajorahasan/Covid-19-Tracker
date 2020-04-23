import 'package:json_annotation/json_annotation.dart';

part 'data_callback.g.dart';

@JsonSerializable()
class DataCallback {
  List<CasesTimeSeries> casesTimeSeries;
  List<Statewise> statewise;
  List<Tested> tested;

  DataCallback({
    this.casesTimeSeries,
    this.statewise,
    this.tested,
  });

  @override
  String toString() =>
      'DataCallback(casesTimeSeries: $casesTimeSeries, statewise: $statewise, tested: $tested)';

  factory DataCallback.fromJson(Map<String, dynamic> json) =>
      _$DataCallbackFromJson(json);

  Map<String, dynamic> toJson() => _$DataCallbackToJson(this);
}

@JsonSerializable()
class CasesTimeSeries {
  String dailyconfirmed;
  String dailydeceased;
  String dailyrecovered;
  String date;
  String totalconfirmed;
  String totaldeceased;
  String totalrecovered;

  CasesTimeSeries({
    this.dailyconfirmed,
    this.dailydeceased,
    this.dailyrecovered,
    this.date,
    this.totalconfirmed,
    this.totaldeceased,
    this.totalrecovered,
  });

  @override
  String toString() {
    return 'CasesTimeSeries(dailyconfirmed: $dailyconfirmed, dailydeceased: $dailydeceased, dailyrecovered: $dailyrecovered, date: $date, totalconfirmed: $totalconfirmed, totaldeceased: $totaldeceased, totalrecovered: $totalrecovered)';
  }

  factory CasesTimeSeries.fromJson(Map<String, dynamic> json) =>
      _$CasesTimeSeriesFromJson(json);

  Map<String, dynamic> toJson() => _$CasesTimeSeriesToJson(this);
}

@JsonSerializable()
class Statewise {
  String active;
  String confirmed;
  String deaths;
  String deltaconfirmed;
  String deltadeaths;
  String deltarecovered;
  String lastupdatedtime;
  String recovered;
  String state;
  String statecode;
  String statenotes;

  Statewise({
    this.active,
    this.confirmed,
    this.deaths,
    this.deltaconfirmed,
    this.deltadeaths,
    this.deltarecovered,
    this.lastupdatedtime,
    this.recovered,
    this.state,
    this.statecode,
    this.statenotes,
  });

  @override
  String toString() {
    return 'Statewise(active: $active, confirmed: $confirmed, deaths: $deaths, deltaconfirmed: $deltaconfirmed, deltadeaths: $deltadeaths, deltarecovered: $deltarecovered, lastupdatedtime: $lastupdatedtime, recovered: $recovered, state: $state, statecode: $statecode, statenotes: $statenotes)';
  }

  factory Statewise.fromJson(Map<String, dynamic> json) =>
      _$StatewiseFromJson(json);

  Map<String, dynamic> toJson() => _$StatewiseToJson(this);
}

@JsonSerializable()
class Tested {
  String positivecasesfromsamplesreported;
  String samplereportedtoday;
  String source;
  String testsconductedbyprivatelabs;
  String totalindividualstested;
  String totalpositivecases;
  String totalsamplestested;
  String updatetimestamp;

  Tested({
    this.positivecasesfromsamplesreported,
    this.samplereportedtoday,
    this.source,
    this.testsconductedbyprivatelabs,
    this.totalindividualstested,
    this.totalpositivecases,
    this.totalsamplestested,
    this.updatetimestamp,
  });

  @override
  String toString() {
    return 'Tested(positivecasesfromsamplesreported: $positivecasesfromsamplesreported, samplereportedtoday: $samplereportedtoday, source: $source, testsconductedbyprivatelabs: $testsconductedbyprivatelabs, totalindividualstested: $totalindividualstested, totalpositivecases: $totalpositivecases, totalsamplestested: $totalsamplestested, updatetimestamp: $updatetimestamp)';
  }

  factory Tested.fromJson(Map<String, dynamic> json) => _$TestedFromJson(json);

  Map<String, dynamic> toJson() => _$TestedToJson(this);
}
