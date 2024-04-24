//Meal class that will contain all the macros and information of the meals from user
class Meal {
  final String mealName;
  final double calories;
  final double carbs;
  final double protein;
  final double fats;
  final double fiber;

  Meal({
    required this.mealName,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fats,
    required this.fiber,
  });
}