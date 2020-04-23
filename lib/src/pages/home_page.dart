import 'package:covidtracker/res/app_colors.dart';
import 'package:covidtracker/res/app_styles.dart';
import 'package:covidtracker/src/data/network/controller/covid_controller.dart';
import 'package:covidtracker/src/data/network/entity/data_callback.dart';
import 'package:covidtracker/src/pages/state_page.dart';
import 'package:covidtracker/src/utils/intent_utils.dart';
import 'package:covidtracker/src/widgets/EmptyView.dart';
import 'package:covidtracker/src/widgets/ListHeaderView.dart';
import 'package:covidtracker/src/widgets/StateView.dart';
import 'package:covidtracker/src/widgets/TotalCasesCard.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Statewise> stateData = [];

  Statewise totalCases;

  bool isConfirmSort = true;
  bool isActiveSort = true;
  bool isRecoverSort = true;
  bool isDeathSort = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, this.fetchData);
  }

  void _goToStatePage(Statewise s) {
    IntentUtil.switchPage(context, StatePage(totalCases: s));
  }

  void fetchData() {
    CovidController(context).getData().then((data) async {
      if (data != null && data.statewise.length > 0) {
        totalCases = data.statewise[0];
        data.statewise.remove(data.statewise[0]);
        print("data is set");
        setState(() {
          totalCases;
          stateData.addAll(data.statewise);
        });
      }
    });
  }

  void _sortByConfirm() {
    Comparator<Statewise> c;
    if (isConfirmSort) {
      c = (a, b) => int.parse(a.confirmed).compareTo(int.parse(b.confirmed));
    } else {
      c = (b, a) => int.parse(a.confirmed).compareTo(int.parse(b.confirmed));
    }

    stateData.sort(c);
    setState(() {
      isConfirmSort = !isConfirmSort;
      stateData;
    });
  }

  void _sortByActive() {
    Comparator<Statewise> c;
    if (isActiveSort) {
      c = (a, b) => int.parse(a.active).compareTo(int.parse(b.active));
    } else {
      c = (b, a) => int.parse(a.active).compareTo(int.parse(b.active));
    }

    stateData.sort(c);
    setState(() {
      isActiveSort = !isActiveSort;
      stateData;
    });
  }

  void _sortByRecover() {
    Comparator<Statewise> c;
    if (isRecoverSort) {
      c = (a, b) => int.parse(a.recovered).compareTo(int.parse(b.recovered));
    } else {
      c = (b, a) => int.parse(a.recovered).compareTo(int.parse(b.recovered));
    }

    stateData.sort(c);
    setState(() {
      isRecoverSort = !isRecoverSort;
      stateData;
    });
  }

  void _sortByDeath() {
    Comparator<Statewise> c;
    if (isDeathSort) {
      c = (a, b) => int.parse(a.deaths).compareTo(int.parse(b.deaths));
    } else {
      c = (b, a) => int.parse(a.deaths).compareTo(int.parse(b.deaths));
    }

    stateData.sort(c);
    setState(() {
      isDeathSort = !isDeathSort;
      stateData;
    });
  }

  Widget getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Covid-19",
          style: TextStyle(fontSize: 24, fontFamily: AppStyles.FONT_BOLD),
        ),
        Icon(Icons.album, color: Colors.white, size: 40),
      ],
    );
  }

  Widget getStateCard() {
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
            ListHeaderView(this._sortByConfirm, this._sortByActive,
                this._sortByRecover, this._sortByDeath),
            if (stateData != null && stateData.length != 0)
              Flexible(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: stateData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return StateView(stateData[index], this._goToStatePage);
                  },
                ),
              )
            else
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: EmptyView(
                  icon: Icons.data_usage,
                  title: 'No Data found.',
                  subTitle: 'Please wait, fetching data.',
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //print("state data is $totalCases & all list is ${stateData.length}");
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              getHeader(),
              SizedBox(height: 36),
              if (totalCases != null)
                TotalCasesCard(totalCases)
              else
                CircularProgressIndicator(),
              SizedBox(height: 36),
              getStateCard()
            ],
          ),
        ),
      ),
    );
  }
}
