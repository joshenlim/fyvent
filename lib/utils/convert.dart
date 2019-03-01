String parseDateTime(String datetime) {
  String date = datetime.split(" ")[0];
  String time = datetime.split(" ")[1];
  
  List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  
  List<String> deconstructDate = date.split("-");
  String year = deconstructDate[0];
  String month = months[int.parse(deconstructDate[1])];
  String day = deconstructDate[2];
  
  String constructDate = "$day $month $year";
  
  List<String> deconstructTime = time.split(":");
  int hour = int.parse(deconstructTime[0]);
  String minute = deconstructTime[1];
  String unit = "AM";
  
  if (hour > 12) {
    hour -= 12;
    unit = "PM";
  }
  
  String constructTime = "$hour:$minute $unit";

  return "$constructDate • $constructTime";
}