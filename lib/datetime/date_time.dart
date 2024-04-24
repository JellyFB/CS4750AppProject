//Returns the day with yyyy + mm + dd
String todayDate() {
  //getting today's date
  var dateTimeObject = DateTime.now();

  //Obtaining the year
  String year = dateTimeObject.year.toString();

  //Obtaining the month
  String month = dateTimeObject.month.toString();
  //Appending a 0 to make each month to have 2 digits
  //(10, 11, 12 will fit)
  if (month.length == 1) {
    month = '0$month';
  }

  //Obtaining the day
  String day = dateTimeObject.day.toString();
  //Appending a 0 to do the same as month
  if (day.length == 1) {
    day = '0$day';
  }

  //Combining all to make desired format
  String properFormat = year + month + day;
  return properFormat;
}

