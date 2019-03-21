import 'package:http/http.dart' as http;
import 'dart:convert';

class OneMapInterface
{
    /// currently:
    /// no input validation for bankName
    /// returns an empty list upon unsuccessful response
    Future<List> getBankLocation(String bankName) async
    {
        final requestURL = "https://developers.onemap.sg/commonapi/search?searchVal=" +
                           bankName + "&returnGeom=Y&getAddrDetails=Y";

        final response = await http.get(requestURL);

        List listOfBanks = [];

        if (response.statusCode == 200)
        {
            final responseJson = json.decode(response.body);

            var address;
            var lat;
            var lng;

            /// responseJson["results"] is a List of Maps,
            /// where each map contain bank branch/ATM info
            for(var bankMap in responseJson["results"])
            {
                address = bankMap["BUILDING"] + ", " + bankMap["ROAD_NAME"];
                lat = bankMap["LATITUDE"];
                lng = bankMap["LONGITUDE"];

                listOfBanks.add({"address": address, "lat": lat, "lng": lng});
                print("added: " + address + " ("+ lat + ", " + lng + ")");
            }
        }
        else
        {
            print("OneMap status code: " + response.statusCode.toString());
        }

        return listOfBanks;
    }
}