import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/meal_tiles.dart';
import '../meals/meal_data.dart';

class PastMealPage extends StatefulWidget {
  const PastMealPage({super.key, required this.title});
  final String title;

  @override
  State<PastMealPage> createState() => _MyPastMealPage();
}

class _MyPastMealPage extends State<PastMealPage> {


  @override
  Widget build(BuildContext context) {
    return Consumer<MealsData>(
      builder: (context, value, child) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade400,
        title: Text(widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontStyle: FontStyle.italic,
            ),
          ),
      ),
      body: ListView.builder(
        itemCount: value.mealList.length,
        itemBuilder: (context, index) => MealTile(
          mealName: value.getMealList()[index].mealName,
          calories: value.getMealList()[index].calories,
          carbs: value.getMealList()[index].carbs,
          protein: value.getMealList()[index].protein,
          fats: value.getMealList()[index].fats,
          fiber: value.getMealList()[index].fiber,
        ),
      )
      ),
    );
  }
}
// child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: <Widget>[
//     // Each button leads to a small excerpt or links about that particular diet
//     const SizedBox(
//       height: 50,
//     ),
//     Container(
//       alignment: Alignment.center,
//       child: ElevatedButton.icon(
//         onPressed: _dietPages,
//         icon: const Icon(
//           Icons.menu_book,
//           size: 30,
//         ),
//         label: const Text('Paleo'),
//       ),
//     ),
//     const SizedBox(
//       width: 30,
//     ),
//     Container(
//       alignment: Alignment.center,
//       child: ElevatedButton.icon(
//         onPressed: _dietPages,
//         icon: const Icon(
//           Icons.menu_book,
//           size: 30,
//         ),
//         label: const Text('Vegan'),
//       ),
//     ),
//     const SizedBox(
//       width: 30,
//     ),
//     Container(
//       alignment: Alignment.center,
//       child: ElevatedButton.icon(
//         onPressed: _dietPages,
//         icon: const Icon(
//           Icons.menu_book,
//           size: 30,
//         ),
//         label: const Text('Vegetarian'),
//       ),
//     ),
//     const SizedBox(
//       width: 30,
//     ),
//     Container(
//       alignment: Alignment.center,
//       child: ElevatedButton.icon(
//         onPressed: _dietPages,
//         icon: const Icon(
//           Icons.menu_book,
//           size: 30,
//         ),
//         label: const Text('Low Carb'),
//       ),
//     ),
//     const SizedBox(
//       width: 30,
//     ),
//     Container(
//       alignment: Alignment.center,
//       child: ElevatedButton.icon(
//         onPressed: _dietPages,
//         icon: const Icon(
//           Icons.menu_book,
//           size: 30,
//         ),
//         label: const Text('Keto'),
//       ),
//     ),
//   ],
// ),