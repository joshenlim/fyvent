import 'package:http/http.dart' as http;
import 'dart:convert';

/// do not call this methods from this file;
/// call methods from api_facade instead

Future<List> getBankLocations(String bankName) async {
  var startTime = DateTime.now();
  List listOfBanks = [];

  if (bankName != 'DBS' && bankName != 'UOB' && bankName != 'OCBC') {
    print('not a valid bank');
  } else {
    var requestURL =
        'https://developers.onemap.sg/commonapi/search?searchVal=' +
            bankName +
            '&returnGeom=Y&getAddrDetails=Y';

    var oneMap = http.Client();
    var response = await oneMap.get(requestURL);

    if (response.statusCode != 200)
      print('Error OneMap for page 1: ' + response.statusCode.toString());
    else {
      var decodedResponse = json.decode(response.body);
      final totalNumPages = decodedResponse['totalNumPages'];
      _addResponseToBankList(decodedResponse, listOfBanks);
      requestURL = requestURL + '&pageNum=';

      for (var pageNum = 2; pageNum <= totalNumPages; pageNum++) {
        response = await oneMap.get(requestURL + pageNum.toString());
        decodedResponse = json.decode(response.body);
        if (response.statusCode != 200) {
          print('Error OneMap for page $pageNum: ' +
              response.statusCode.toString());
        } else {
          _addResponseToBankList(decodedResponse, listOfBanks);
        }
      }
    }

    oneMap.close();
  }

  var timeTaken =
      DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;
  print('time taken: $timeTaken');

  return listOfBanks;
}

void _addResponseToBankList(Map decodedResponse, List listOfBanks) {
  decodedResponse['results'].forEach((bankJson) {
    listOfBanks.add({
      'address': bankJson['BUILDING'] + ', ' + bankJson['ROAD_NAME'],
      'lat': bankJson['LATITUDE'],
      'lng': bankJson['LONGITUDE'],
    });
  });
}
