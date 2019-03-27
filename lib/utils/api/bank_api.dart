import 'package:http/http.dart' as http;
import 'dart:convert';

/// do not call this methods from this file;
/// call methods from api_facade instead

Future<List> getBankLocations(String bankName) async {
  List listOfBanks = [];
  final requestURL =
      "https://developers.onemap.sg/commonapi/search?searchVal=" +
          bankName +
          "&returnGeom=Y&getAddrDetails=Y";

  final response = await http.get(requestURL);
  if (response.statusCode == 200) {
    final responseJson = json.decode(response.body);
    responseJson["results"].forEach((bank) {
      listOfBanks.add({
        "address": bank["BUILDING"] + ", " + bank["ROAD_NAME"],
        "lat": bank["LATITUDE"],
        "lng": bank["LONGITUDE"],
      });
    });
  } else {
    print("Error OneMap: " + response.statusCode.toString());
  }
  return listOfBanks;
}