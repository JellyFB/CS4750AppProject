import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../meals/meal_data.dart';

//Tiles that display the macros of meals in the "ADDED MEALS PAGE"
class MealTile extends StatelessWidget {
  const MealTile({super.key,
    required this.mealName,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fats,
    required this.fiber});

  final String mealName;
  final double calories;
  final double carbs;
  final double protein;
  final double fats;
  final double fiber;

  @override
  Widget build(BuildContext context) {
    return Consumer<MealsData>(
        builder: (context, value, child) => Container(
          color: Colors.blueGrey.shade50,
          child: ListTile(
              hoverColor: Colors.lightBlueAccent.shade100,
              title: Text(mealName, style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                  )
              ),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Chip(
                        backgroundColor: Colors.blueAccent.shade100,
                        label: Text("Calories: $calories", style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )
                        )
                    ),
                    Row(
                      children: [
                        Chip(
                            backgroundColor: Colors.blueAccent.shade100,
                            label: Text("Carb: $carbs g", style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            )
                            )
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Chip(
                            backgroundColor: Colors.blueAccent.shade100,
                            label: Text("Protein: $protein g", style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            )
                            )
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Chip(
                            backgroundColor: Colors.blueAccent.shade100,
                            label: Text("Fat: $fats g", style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            )
                            )
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Chip(
                            backgroundColor: Colors.blueAccent.shade100,
                            label: Text("Fiber: $fiber g", style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            )
                            )
                        ),
                      ],
                    )
                  ]
              ),
          ),
        ),
    );
  }
}