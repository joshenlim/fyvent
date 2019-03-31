import 'package:http/http.dart' as http;
import 'dart:convert';

/// do not call this methods from this file;
/// call methods from api_facade instead

final accountKey = "II2mAyMiRWy0o4L/jVwzzQ==";

Future<List> getCarparkLocations() async {
  List listOfCarparks = [];
  final requestURL =
      "http://datamall2.mytransport.sg/ltaodataservice/CarParkAvailabilityv2";

  final response =
      await http.get(requestURL, headers: {'AccountKey': accountKey});
  if (response.statusCode == 200) {
    final responseJson = json.decode(response.body);
    responseJson["value"].forEach((carpark) {
      if (carpark["LotType"] == "C" || carpark["LotType"] == "M") {
        if (carpark["Location"].length > 0) {
          List<String> latLng = carpark["Location"].split(" ");
          // print(latLng.toString() + " : " + latLng.length.toString());
          String carparkAddress = carpark["Area"].length > 0
              ? carpark["Development"] + " (" + carpark["Area"] + ")"
              : carpark["Development"];
          listOfCarparks.add({
            "address": carparkAddress,
            "lat": latLng[0],
            "lng": latLng[1],
            "availableLots": carpark["AvailableLots"],
          });
        }
      }
    });
  } else {
    print("Error Datamall: " + response.statusCode.toString());
  }
  return listOfCarparks;
}
