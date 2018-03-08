import 'dart:async';

import 'package:flutter_drib/api/basicApi.dart';
import 'package:flutter_drib/model/dribbble_shot.dart';

class ShotsApi extends BasicApi {

  //Get shorts
  //Sort types: views / recent
  //Limit: result size limit
  Future<List<DribbbleShot>> getShots(String sortType, int limit) async {
    List<DribbbleShot> shots = new List<DribbbleShot>();
    List<Map<String, dynamic>> callResult = await request(
        "/v1/shots", {"sort": sortType, "per_page": limit.toString()});
    if (callResult != null) {
      callResult.forEach((shotString) {
        shots.add(DribbbleShot.fromJson(shotString));
      });
    }
    return shots;
  }


}