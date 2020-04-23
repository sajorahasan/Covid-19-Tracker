import 'dart:convert';

import 'package:covidtracker/src/data/network/controller/base_controller.dart';
import 'package:covidtracker/src/data/network/entity/data_callback.dart';
import 'package:covidtracker/src/data/network/webservice_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CovidController extends BaseController {
  CovidController(BuildContext context) : super(context);

  // Future<List<Statewise>> getData() async {
  //   WebRequestBuilder builder = WebRequestBuilder(
  //     CovidURL.getData,
  //     context: mContext,
  //     header: getHeader(),
  //   );

  //   try {
  //     String json = await builder.build().get();

  //     Map userMap = jsonDecode(json);
  //     var res = DataCallback.fromJson(userMap);

  //     List<Statewise> statesData = [];
  //     statesData.add(new Statewise(state: "Gujarat"));
  //     // for (var u in res.statewise) {
  //     //   statesData.add(new Statewise(state: u.state));
  //     // }

  //     print("statesData--> ${statesData.length}");
  //     return statesData;
  //   } on ResponseError catch (e) {
  //     showLog("Erroor-> $e");
  //   }

  //   return null;
  // }

  Future<DataCallback> getData() async {
    try {
      Response response = await Dio().get(CovidURL.getData);
      if (response.statusCode == 200) {
        final res = DataCallback.fromJson(response.data);
        print("res--2> ${res.toJson()}");
        return res;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<Statewise>> getStateData(String stateCode) async {
    try {
      Response response = await Dio().get(CovidURL.getStateData);

      if (response.statusCode == 200) {
        var data = response.data;

        List<Statewise> statesData = [];
        for (var d in data.keys) {
          var sc = data[d]['statecode'];
          if (sc == stateCode) {
            var temp = data[d]['districtData'];

            temp.forEach((final String key, final t) {
              Statewise st = new Statewise();
              st.statecode = sc;
              st.state = key;
              st.confirmed = t["confirmed"].toString();
              st.active = t["active"].toString();
              st.recovered = t["recovered"].toString();
              st.deaths = t["deceased"].toString();
              st.deltaconfirmed = t["delta"]["confirmed"].toString();
              st.deltarecovered = t["delta"]["recovered"].toString();
              st.deltadeaths = t["delta"]["deceased"].toString();
              st.statenotes = t["notes"];
              statesData.add(st);
            });
          }
        }
        print("statesData ---> $statesData");
        return statesData;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
