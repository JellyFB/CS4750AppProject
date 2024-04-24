import 'package:flutter/material.dart';

//Creating the widget to get the date at the top of the main screen
class CurrentDateWidget extends StatelessWidget {
  const CurrentDateWidget({super.key});
  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime now = DateTime.now();

    var month = ['January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

    // Format the date as you desire
    int whatMonth = now.month - 1;
    String formattedDate = '${month[whatMonth]} ${now.day}, ${now.year}';

    return Text(
      formattedDate,
      selectionColor: Colors.blueGrey,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
    );
  }
}