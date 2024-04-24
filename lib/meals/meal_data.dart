import 'package:flutter/cupertino.dart';
import 'package:test_flutter_project/meals/hive_database.dart';
import 'meals.dart';


class MealsData extends ChangeNotifier {

  final database = HiveDataBase();

  //Creating the meal list to display all meals created
  List<Meal> mealList = [
  ];

  //If there exists meals then call that from the database otherwise begin entering data
  void initializeMealList() {
    if (database.previousDataExist()) {
      mealList = database.readingFromDatabase();
    } else {
      database.saveToDataBase(mealList);
    }
  }

  //Obtaining a list of the dishes in the meal
  List<Meal> getMealList() {
    return mealList;
  }

  //Adding a meal (purpose of the app)
  void addMeal(String name, double calories, double carbs,
      double protein, double fats, double fiber) {

    mealList.add(Meal(mealName: name, calories: calories, carbs: carbs,
        protein: protein, fats: fats, fiber: fiber));
    notifyListeners();

    database.saveToDataBase(mealList);
  }

}