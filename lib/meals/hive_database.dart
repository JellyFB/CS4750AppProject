import 'package:hive/hive.dart';
import '../datetime/date_time.dart';
import 'meals.dart';

class HiveDataBase {

  //Referencing the database / hive box
  final _myBox = Hive.box("meal_database");

  //Checking if there is already data stored
  bool previousDataExist() {
    if (_myBox.isEmpty) {
      // print("No previous data exists in the local storage");
      _myBox.put("START_DATE", todayDate());
      return false;
    }
    else {
      // print("Previous data does exist in the local storage");
      return true;
    }
  }

  //Saving the data for MEALS
  void saveToDataBase(List<Meal> meals) {
    final mealMacro = convertObjectsInMeals(meals);

    _myBox.put("MEALS", mealMacro);
  }

  //Saving the data for setting the calorie goal
  void saveCalorieToDataBase(double calorieGoal) {
    _myBox.put("CALORIE GOAL", calorieGoal);
  }

  //Reading the data to set the calorie goal
  double readingCalorieFromDatabase() {
    //If there was no value to begin with then just return the generic 2000 goal
    if (_myBox.get("CALORIE GOAL") == null) {
      //Auto set value
      return 2000.0;
    }
    else {
      final calorieGoal = _myBox.get("CALORIE GOAL");
      return calorieGoal;
    }
  }


  //Reading from the database for MEALS
  List<Meal> readingFromDatabase() {
    List<Meal> savedMeals = [];

    final mealMacro = _myBox.get("MEALS", defaultValue: 'List<List<String>>');

    //Reading the values which is a nested list (2D array) and inputting the attributes
    for (int j = 0; j < mealMacro.length; j++) {
      savedMeals.add(Meal(
          mealName: mealMacro[j][0],
          calories: double.parse(mealMacro[j][1]),
          carbs: double.parse(mealMacro[j][2]),
          protein: double.parse(mealMacro[j][3]),
          fats: double.parse(mealMacro[j][4]),
          fiber: double.parse(mealMacro[j][5])
          )
        );
    }
    return savedMeals;
  }
}

//Converts all the individual macros of a meal into strings and adds to a list
//Basically a list that is a list of strings of all the meals and its macros
List<List<String>> convertObjectsInMeals(List<Meal> meals) {
  List<List<String>> allMeals = [];

  for (int i = 0; i < meals.length; i++) {
   List<String> mealMacros = [];

    mealMacros.addAll(
      [
        meals[i].mealName,
        meals[i].calories.toString(),
        meals[i].carbs.toString(),
        meals[i].protein.toString(),
        meals[i].fats.toString(),
        meals[i].fiber.toString(),
      ]
    );
    allMeals.add(mealMacros);
  }
  return allMeals;

}