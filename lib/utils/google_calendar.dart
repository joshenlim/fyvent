import 'dart:async' show Future;
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/io_client.dart';

final _credentials = new ServiceAccountCredentials.fromJson({
  "private_key_id": "d3a3eb70bd0c048e01161c57889802750e055030",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC0KC+Hkipqw2V5\nKbDNJ4EzB0RjoRNrFXyEl/DnrdJ5YmKLQkoiCOqNexgckGhgGAQZnz3PpN34iamb\n3+SckIjqpV+APU4rk9jh1KrjELImrwXztEQTGsZ7GtH3WZXj16z44DIAi64xkPjE\nkTKM7XPxXCH78/J36rWG4CvAhuRo1dRl4pBxjKU6c3X6JzQhYvTGVyj0DDtQx7YI\n8nTGhXuNqlD6HSAHUzeG326fqUx6iUxK99cZ7njDKmWOnQu3dsxWfA4mzEaU5YCI\nVDjGrDiKCdz+HD0isAuUL7QHVbc+9aeWQk19RrAJktwXOz/Zrs2l0ymGgUPs661g\nzKYfF6K7AgMBAAECggEABKSYfPz2XOQGRHYfmVnwSXlheNPY5USbfetQiRgAuaIg\neghOUsw6B0Vp3KqYFgnoaSSieix8kAA0P9EoWiSbcriqWmq6DgN0bnWFpe5zOO3/\n0EUQEBH7lYaebKqBY2rWiV91ym/PIHXlA2PekqU3/LtsIMsrr417+iri1cZkMpNt\nIKKQXmZgO0Em858AaZN+0y0p64m40zyPGiHd45XeZSD7OwPyx7maWdn6haPJNMa4\neL2+SiXithruJQRbAVi33HQII36pHyLJn0UmYlXD/NoOM7gie1E9jHYP1Yo4oTVB\nIrWfr0ofCWanJaxqkKB9y3bJ0XssAIn+RaYanORisQKBgQDazWX3z+ruM2zNAQyu\nGn66LFNJzwdpYYyhpD+EqtUuD43NhBm82qaZ7+CdY6M1XSAAYum/ec6hc2MzbrOn\nBQTVqsqlaeNIOwzbgFL9qstyYT+QrR//br/DMI2mrkTUS83SPq6sR4xIzWCEs8+l\nnv1QF9bpmKt64dj2+XZj1Kz/swKBgQDSyOJMZcz3zay/l1lEnPVybcI6SGN+4YgG\nfuzVg9pxHJhxRfBSGMK7ruSw20aumUEX2SswWQMQdFxNQ3Rg8/cCd5HLBsEwZknn\nQhcb9riPMqK6/u96kKpHOMxLjTKCVdg1I5//poZdm23TK7WIL57IlolRUZGoWSG/\nGOs2Km+M2QKBgQCgTny2446sluDQEkTICoFuxasAGL7FZsMyarRe7wrhhGPQf0ic\nJVaK0kUvCyE4p9Iadl3r+8J4Z6H2vNTDOdog8dEnAD2VXi49Y/dqAwir9LQtu6oF\n645z487koCmtoRxbPbGcZ49Qh6h/kX5BSgst80lyPHjmvzHHQV6MJfXaIQKBgEtV\nrsO9Up9ya/5h2m7SZksKfXOVMbJEavhfXsgFAwqQPM+nPngpD1hC7sti44U9ku0y\nGeSCu7yiyeZ3aF3KdAr2ry3P8TYaKOm1TksZR+cuIskQmojEsYcY/rM1+MpqYgbD\n/8hAPR+xkHP72DqfQnHQk61zqMpxaMVC47YNPqcpAoGAW399e0bmsBRuJ8+pFb+p\nA/YlZClUJCQj1BGjC9mWDHdJK6F2zTSpMauXMu6GFyjIGAEF2+u6W6tQQSRqvs4q\nInC3qmff+UqkSQ+/UnnmEh+EyoGKfd6pYbITmeFpsdZbedCQLPPxGNeaXSqEOEQV\nBTXhoQHaNr7z8yBA2dKgyHQ=\n-----END PRIVATE KEY-----\n",
  "client_email": "fyvent-calendar@fyvent-27d5a.iam.gserviceaccount.com",
  "client_id": "103161605095276766040",
  "type": "service_account"
});

final _scopes = [CalendarApi.CalendarScope];

void getCalendarEvents() {
  print("Getting");
  clientViaServiceAccount(_credentials, _scopes).then((client) {
    var calendar = new CalendarApi(client);
    calendar.events.list("primary").then((res) {
      print("calEvents: " + res.toString() + " " + res.items.length.toString());
      res.items.forEach((event) {
        print(event.summary);
        print(event.start.dateTime);
        print(event.htmlLink);
      });
    });
  });
}


Future<void> insertEvent(String timeStart, String timeEnd, String eventName, String location) async{
  clientViaServiceAccount(_credentials, _scopes).then((client) {
    CalendarApi(client)
    .events.insert(
      Event.fromJson(
        toRequestObject(timeStart, timeEnd, eventName, location)
      ),
      "primary"
    );
  });
}

Map toRequestObject(String timeStart,String timeEnd,String eventName, String location){
  return {
    "end": {
      "dateTime" : "2019-03-23T10:30:00+00:00"
    },
    "start":{
      "dateTime" : "2019-03-23T10:00:00+00:00"
    },
    "summary": "Hi",
    "location": "NTU"
  };
}