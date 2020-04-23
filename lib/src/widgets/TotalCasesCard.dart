import 'package:covidtracker/res/app_colors.dart';
import 'package:covidtracker/res/app_styles.dart';
import 'package:covidtracker/src/data/network/entity/data_callback.dart';
import 'package:covidtracker/src/utils/calendar_utils.dart';
import 'package:covidtracker/src/utils/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class TotalCasesCard extends StatelessWidget {
  final Statewise totalCases;

  TotalCasesCard(this.totalCases);

  @override
  Widget build(BuildContext context) {
    final infoBox =
        (String caseNo, String todayCase, Color color, String label) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        caseNo,
                        style: TextStyle(
                            fontSize: 20,
                            color: color,
                            fontFamily: AppStyles.FONT_BOLD),
                      ),
                      if (int.parse(todayCase) > 0) SizedBox(width: 4),
                      if (int.parse(todayCase) > 0)
                        Icon(Icons.trending_up, color: color, size: 12),
                      if (int.parse(todayCase) > 0)
                        Text(
                          todayCase,
                          style: TextStyle(
                              fontSize: 12,
                              color: color,
                              fontFamily: AppStyles.FONT_BOLD),
                        ),
                    ],
                  ),
                  Text(label)
                ],
              ),
            );

    var dateTime =
        CalendarUtils.parse(totalCases.lastupdatedtime, 'dd/MM/yyyy hh:mm:ss');
    var lastUpdated = timeago.format(dateTime);

    return Card(
      elevation: 3,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("CURRENT CASES IN INDIA", style: TextStyle(fontSize: 14)),
            SizedBox(height: 6),
            Text("Last updated $lastUpdated", style: TextStyle(fontSize: 10)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                infoBox(
                    NumberUtils.format(totalCases.confirmed),
                    NumberUtils.format(totalCases.deltaconfirmed),
                    Colors.red,
                    "Confirmed"),
                infoBox(NumberUtils.format(totalCases.active), "0", Colors.blue,
                    "Active     "),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                infoBox(NumberUtils.format(totalCases.recovered),
                    totalCases.deltarecovered, Colors.green, "Recovered"),
                infoBox(NumberUtils.format(totalCases.deaths),
                    totalCases.deltadeaths, Colors.grey, "Deceased"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
