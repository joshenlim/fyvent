import "package:fyvent/models/event.dart";
import 'white_box_list.dart';


String parseTime(int hour, String minute) {
  String unit = "AM"; runtimePath2.add(1);
  runtimePath2.add(2);
  if (hour > 12) {
    hour -= 12; runtimePath2.add(3);
    unit = "PM"; runtimePath2.add(4);
  }
  runtimePath2.add(5);
  return "$hour:$minute $unit";
}

String parseDateTime(String datetime) {
  String date = datetime.split(" ")[0];
  String time = datetime.split(" ")[1];
  
  List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  
  List<String> deconstructDate = date.split("-");
  String year = deconstructDate[0];
  String month = months[int.parse(deconstructDate[1]) - 1];
  String day = deconstructDate[2];
  
  String constructDate = "$day $month $year";
  
  List<String> deconstructTime = time.split(":");
  int hour = int.parse(deconstructTime[0]);
  String minute = deconstructTime[1];
  String constructTime = parseTime(hour, minute);

  return "$constructDate • $constructTime";
}
  
String parseDatetimeRange(String start, String end) {

  List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];runtimePath1.add(1);
 
  String startDate = start.split(" ")[0]; runtimePath1.add(2);

  
  String startTime = start.split(" ")[1]; runtimePath1.add(3);
  
  List<String> deconstructStartDate = startDate.split("-"); runtimePath1.add(4);
  
  String startYear = deconstructStartDate[0]; runtimePath1.add(5);
  String startMonth = deconstructStartDate[1]; runtimePath1.add(6);
  String startDay = deconstructStartDate[2]; runtimePath1.add(7);
  
  List<String> deconstructStartTime = startTime.split(":"); runtimePath1.add(8);
  
  int startHour 			= int.parse(deconstructStartTime[0]); runtimePath1.add(9);
  String startMinute 	= deconstructStartTime[1]; runtimePath1.add(10);
  
  String endDate = end.split(" ")[0]; runtimePath1.add(11);
  String endTime = end.split(" ")[1]; runtimePath1.add(12);
  
  List<String> deconstructEndDate	= endDate.split("-"); runtimePath1.add(13);
  
  String endYear = deconstructEndDate[0];runtimePath1.add(14);
  String endMonth = deconstructEndDate[1];runtimePath1.add(15);
  String endDay = deconstructEndDate[2]; runtimePath1.add(16);
  
  List<String> deconstructEndTime = endTime.split(":"); runtimePath1.add(17);
  
  int endHour 			= int.parse(deconstructEndTime[0]); runtimePath1.add(18);
  String endMinute 	= deconstructEndTime[1]; runtimePath1.add(19);
  
  runtimePath1.add(20);
  if (startYear == endYear &&
      startMonth == endMonth &&
      startDay == endDay) {
    String parsedStartMonth = months[int.parse(startMonth) - 1]; runtimePath1.add(21);
    String constructDate = "$startDay $parsedStartMonth $startYear"; runtimePath1.add(22);
    
    String parsedStartTime = parseTime(startHour, startMinute); runtimePath1.add(23);
    String parsedEndTime = parseTime(endHour, endMinute); runtimePath1.add(24);
    
    runtimePath1.add(25);
    return "$constructDate • $parsedStartTime - $parsedEndTime"; 
  } else {
    String parsedStartMonth = months[int.parse(startMonth) - 1];runtimePath1.add(26);
    String parsedEndMonth = months[int.parse(endMonth) - 1]; runtimePath1.add(27);
    
    String constructStartDate = "$startDay $parsedStartMonth $startYear"; runtimePath1.add(28);
    String constructEndDate = "$endDay $parsedEndMonth $endYear";runtimePath1.add(29);
    
    String constructDateRange = "$constructStartDate - $constructEndDate" ;runtimePath1.add(30);
    String parsedStartTime = parseTime(startHour, startMinute); runtimePath1.add(31);
    String parsedEndTime = parseTime(endHour, endMinute); runtimePath1.add(32);

    runtimePath1.add(33);
    return "$constructDateRange • $parsedStartTime - $parsedEndTime";
  }  
}

bool checkIfEventInFavourites(List favourites, int id) {
  bool found = false;
  favourites.forEach((item) {
    if (item['id'] == id) found = true;
  });
  return found;
}

bool checkIfEventInUserFavourites(List<Event> favourites, int id) {
  bool found = false;
  favourites.forEach((item) {
    if (item.getId() == id) found = true;
  });
  return found;
}