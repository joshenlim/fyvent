class Counter{

  void trackline(line){
    print("line" + line.toString());
  }
}

Counter c = Counter();

String parseTime(int hour, String minute) {
  String unit = "AM";
  if (hour > 12) {
    hour -= 12;
    unit = "PM";
  }
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
  List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]; c.trackline(1);
  
  String startDate = start.split(" ")[0]; c.trackline(2);
  String startTime = start.split(" ")[1]; c.trackline(3);
  
  List<String> deconstructStartDate = startDate.split("-"); c.trackline(4);
  
  String startYear = deconstructStartDate[0]; c.trackline(5);
  String startMonth = deconstructStartDate[1]; c.trackline(6);
  String startDay = deconstructStartDate[2]; c.trackline(7);
  
  List<String> deconstructStartTime = startTime.split(":"); c.trackline(8);
  
  int startHour 			= int.parse(deconstructStartTime[0]); c.trackline(9);
  String startMinute 	= deconstructStartTime[1]; c.trackline(10);
  
  String endDate = end.split(" ")[0]; c.trackline(11);
  String endTime = end.split(" ")[1]; c.trackline(12);
  
  List<String> deconstructEndDate	= endDate.split("-"); c.trackline(13);
  
  String endYear = deconstructEndDate[0]; c.trackline(14);
  String endMonth = deconstructEndDate[1]; c.trackline(15);
  String endDay = deconstructEndDate[2]; c.trackline(16);
  
  List<String> deconstructEndTime = endTime.split(":"); c.trackline(17);
  
  int endHour 			= int.parse(deconstructEndTime[0]); c.trackline(18);
  String endMinute 	= deconstructEndTime[1]; c.trackline(19);
  
  if (startYear == endYear &&
      startMonth == endMonth &&
      startDay == endDay) {
    c.trackline(20);

    String parsedStartMonth = months[int.parse(startMonth) - 1]; c.trackline(21);
    String constructDate = "$startDay $parsedStartMonth $startYear"; c.trackline(22);
    
    String parsedStartTime = parseTime(startHour, startMinute); c.trackline(23);
    String parsedEndTime = parseTime(endHour, endMinute); c.trackline(24);
    
    c.trackline(25);
    return "$constructDate • $parsedStartTime - $parsedEndTime"; 
  } else {
    String parsedStartMonth = months[int.parse(startMonth) - 1]; c.trackline(26);
    String parsedEndMonth = months[int.parse(endMonth) - 1]; c.trackline(27);
    
    String constructStartDate = "$startDay $parsedStartMonth $startYear"; c.trackline(28);
    String constructEndDate = "$endDay $parsedEndMonth $endYear"; c.trackline(29);
    
    String constructDateRange = "$constructStartDate - $constructEndDate"; c.trackline(30);
    String parsedStartTime = parseTime(startHour, startMinute); c.trackline(31);
    String parsedEndTime = parseTime(endHour, endMinute); c.trackline(32);

    c.trackline(33);
    return "$constructDateRange • $parsedStartTime - $parsedEndTime";
  } 
}