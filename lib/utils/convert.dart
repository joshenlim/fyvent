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
  List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  
  String startDate = start.split(" ")[0];
  String startTime = start.split(" ")[1];
  
  List<String> deconstructStartDate = startDate.split("-");
  
  String startYear = deconstructStartDate[0];
  String startMonth = deconstructStartDate[1];
  String startDay = deconstructStartDate[2];
  
  List<String> deconstructStartTime = startTime.split(":");
  
  int startHour 			= int.parse(deconstructStartTime[0]);
  String startMinute 	= deconstructStartTime[1];
  
  String endDate = end.split(" ")[0];
  String endTime = end.split(" ")[1];
  
  List<String> deconstructEndDate	= endDate.split("-");
  
  String endYear = deconstructEndDate[0];
  String endMonth = deconstructEndDate[1];
  String endDay = deconstructEndDate[2];
  
  List<String> deconstructEndTime = endTime.split(":");
  
  int endHour 			= int.parse(deconstructEndTime[0]);
  String endMinute 	= deconstructEndTime[1];
  
  if (startYear == endYear &&
      startMonth == endMonth &&
      startDay == endDay) {
    String parsedStartMonth = months[int.parse(startMonth) - 1];
    String constructDate = "$startDay $parsedStartMonth $startYear";
    
    String parsedStartTime = parseTime(startHour, startMinute);
    String parsedEndTime = parseTime(endHour, endMinute);
    
    return "$constructDate • $parsedStartTime - $parsedEndTime";
  } else {
    String parsedStartMonth = months[int.parse(startMonth) - 1];
    String parsedEndMonth = months[int.parse(endMonth) - 1];
    
    String constructStartDate = "$startDay $parsedStartMonth $startYear";
    String constructEndDate = "$endDay $parsedEndMonth $endYear";
    
    String constructDateRange = "$constructStartDate - $constructEndDate";
    String parsedStartTime = parseTime(startHour, startMinute);
    String parsedEndTime = parseTime(endHour, endMinute);
    return "$constructDateRange • $parsedStartTime - $parsedEndTime";
  }  
}