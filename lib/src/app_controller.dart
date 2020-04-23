import 'package:covidtracker/res/app_colors.dart';
import 'package:covidtracker/res/app_styles.dart';
import 'package:covidtracker/src/navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';

class CovidApp extends StatelessWidget {
  static var APP_GLOBAL_KEY = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: APP_GLOBAL_KEY,
      title: "Covid-19",
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: AppColors.accentColor,
        scaffoldBackgroundColor: AppColors.appBackground,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              fontFamily: AppStyles.FONT_REGULAR,
            ),
      ),
      home: MyBottomNavigation(),
    );
  }
}
