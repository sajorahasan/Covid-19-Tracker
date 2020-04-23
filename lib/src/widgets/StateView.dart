import 'package:covidtracker/src/data/network/entity/data_callback.dart';
import 'package:covidtracker/src/utils/num_utils.dart';
import 'package:flutter/material.dart';

class StateView extends StatelessWidget {
  final Statewise stateData;
  final void Function(Statewise) onPress;

  StateView(this.stateData, this.onPress);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress(stateData),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(flex: 2, child: Text(stateData.state)),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  if (int.parse(stateData.deltaconfirmed) > 0)
                    Text(
                      "+${stateData.deltaconfirmed} ",
                      style: TextStyle(fontSize: 8, color: Colors.redAccent),
                    ),
                  Text(
                    NumberUtils.format(stateData.confirmed),
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(NumberUtils.format(stateData.active),
                        style: TextStyle(fontSize: 12)))),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  if (int.parse(stateData.deltarecovered) > 0)
                    Text(
                      "+${stateData.deltarecovered} ",
                      style: TextStyle(fontSize: 8, color: Colors.greenAccent),
                    ),
                  Text(NumberUtils.format(stateData.recovered),
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  if (int.parse(stateData.deltadeaths) > 0)
                    Text(
                      "+${stateData.deltadeaths} ",
                      style: TextStyle(fontSize: 8, color: Colors.grey),
                    ),
                  Text(NumberUtils.format(stateData.deaths),
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
