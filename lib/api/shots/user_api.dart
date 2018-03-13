import 'dart:async';

import 'package:flutter_drib/api/basicApi.dart';
import 'package:flutter_drib/model/dribbble_shot.dart';
import 'package:flutter_drib/model/dribbble_user.dart';

class UserApi extends BasicApi {

  Future<List<DribbbleShot>> getShotsByUser(DribbbleUser user,
      int limit) async {
    List<DribbbleShot> shots = new List<DribbbleShot>();
    List<Map<String, dynamic>> callResult = await request(
        "/v1/users/${user.id}/shots/", { "per_page": limit.toString()});
    if (callResult != null) {
      callResult.forEach((shotString) {
        var shot = DribbbleShot.fromJson(shotString);
        //Add user to shot
        shots.add(new DribbbleShot(
            shot.title,
            shot.id,
            shot.images,
            user,
            shot.description,
            shot.likesCount,
            shot.viewsCount,
            shot.bucketCount,
            shot.commentsCount,
            shot.animated,
            shot.tags));
      });
    }
    return shots;
  }

}