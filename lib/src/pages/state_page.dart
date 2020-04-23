import 'package:covidtracker/res/app_colors.dart';
import 'package:covidtracker/res/app_styles.dart';
import 'package:covidtracker/src/data/network/controller/covid_controller.dart';
import 'package:covidtracker/src/data/network/entity/data_callback.dart';
import 'package:covidtracker/src/utils/intent_utils.dart';
import 'package:covidtracker/src/utils/num_utils.dart';
import 'package:covidtracker/src/widgets/EmptyView.dart';
import 'package:covidtracker/src/widgets/TotalCasesCard.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatePage extends StatefulWidget {
  final Statewise totalCases;
  StatePage({Key key, @required this.totalCases}) : super(key: key);

  @override
  _StatePageState createState() => _StatePageState(totalCases);
}

class _StatePageState extends State<StatePage> {
  List<Statewise> districtsData = [];
  final Statewise totalCases;
  bool isConfirmSort = true;

  _StatePageState(this.totalCases);

  @override
  void initState() {
    super.initState();
    //Future.delayed(Duration.zero, this.fetchData);
  }

  Future<List<Statewise>> fetchData() async {
    return await CovidController(context).getStateData(totalCases.statecode);
  }

  void _goBack() => IntentUtil.goBack(context);

  Widget getHeader() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () => this._goBack(),
            icon: Icon(Icons.close, color: Colors.white, size: 30),
          ),
        ),
        Flexible(
          child: Text(
            "${totalCases.state.toUpperCase()} STATISTIC",
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }

  Widget getDistrictsCard() {
    double height = MediaQuery.of(context).size.height;
    return Card(
      elevation: 3,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: height / 2.65,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text("District",
                      style: TextStyle(fontFamily: AppStyles.FONT_BOLD)),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text("Confirmed",
                          style: TextStyle(
                              fontFamily: AppStyles.FONT_BOLD,
                              color: Colors.red)),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: FutureBuilder<List<Statewise>>(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data.length != 0) {
                      districtsData = [];
                      districtsData.addAll(snapshot.data);
                      return Flexible(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: districtsData.length,
                          itemBuilder: (BuildContext context, int index) {
                            Statewise dis = districtsData[index];
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(flex: 2, child: Text(dis.state)),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        if (int.parse(dis.deltaconfirmed) > 0)
                                          Text(
                                            "+${dis.deltaconfirmed} ",
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Colors.redAccent),
                                          ),
                                        Text(
                                          NumberUtils.format(dis.confirmed),
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: EmptyView(
                          icon: Icons.data_usage,
                          title: 'No Data found.',
                          subTitle: 'Please wait, fetching data.',
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: getHeader(),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TotalCasesCard(totalCases),
                    SizedBox(height: 36),
                    getDistrictsCard(),
                    SizedBox(height: 36)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
