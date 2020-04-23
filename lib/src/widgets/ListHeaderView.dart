import 'package:covidtracker/res/app_styles.dart';
import 'package:flutter/material.dart';

class ListHeaderView extends StatelessWidget {
  final void Function() sortByConfirm;
  final void Function() sortByActive;
  final void Function() sortByRecover;
  final void Function() sortByDeath;

  ListHeaderView(this.sortByConfirm, this.sortByActive, this.sortByRecover,
      this.sortByDeath);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text("State/UT",
              style: TextStyle(fontFamily: AppStyles.FONT_BOLD)),
        ),
        Expanded(
          child: InkWell(
            onTap: () => this.sortByConfirm(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text("C",
                    style: TextStyle(
                        fontFamily: AppStyles.FONT_BOLD, color: Colors.red)),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => this.sortByActive(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text("A",
                    style: TextStyle(
                        fontFamily: AppStyles.FONT_BOLD, color: Colors.blue)),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => this.sortByRecover(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text("R",
                    style: TextStyle(
                        fontFamily: AppStyles.FONT_BOLD, color: Colors.green)),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => this.sortByDeath(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text("D",
                    style: TextStyle(
                        fontFamily: AppStyles.FONT_BOLD, color: Colors.grey)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
