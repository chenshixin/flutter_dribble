//Basic api

import 'dart:convert';
import 'dart:io';

import 'package:flutter_drib/keys.dart';

class BasicApi {

  static const String BASE_URL = "api.dribbble.com";

  request(String path, Map params, {String method = "GET"}) async {
    var httpClient = new HttpClient();
    var uri = new Uri.https(BASE_URL, path, params);
    var request;
    //Only post and get for this moment, add others later.
    if (method == "POST") {
      request = await httpClient.postUrl(uri);
    } else {
      request = await httpClient.getUrl(uri);
    }
    request.headers.add("Authorization", "Bearer $DRIBBBLE_ACCESS_TOKEN");
    var response = await request.close();
    var result;
    if (response.statusCode == HttpStatus.OK) {
      var responseBody = await response.transform(UTF8.decoder).join();
      result = json.decode(responseBody);
    }
    return result;
  }

}