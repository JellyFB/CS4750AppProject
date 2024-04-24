import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../meals/meal_data.dart';


//Add Meal Screen
class AddMealPage extends StatefulWidget {
  const AddMealPage({super.key, required this.title});
  final String title;

  @override
  State<AddMealPage> createState() => _AddMealPageState();

}

class _AddMealPageState extends State<AddMealPage> {

  //Input controllers for all the text fields
  final mealNameGettingController = TextEditingController();
  final newCalorieGettingController = TextEditingController();
  final newCarbGettingController = TextEditingController();
  final newProteinGettingController = TextEditingController();
  final newFatGettingController = TextEditingController();
  final newFiberGettingController = TextEditingController();

  //Creating meals and saving the inputted values
  void saveMeal() {
    //Obtaining all the values from a meal and creating the object with those attributes
      String mealName = mealNameGettingController.text;
      double calories = double.parse(newCalorieGettingController.text);
      double carbs = double.parse(newCarbGettingController.text);
      double protein = double.parse(newProteinGettingController.text);
      double fats = double.parse(newFatGettingController.text);
      double fiber = double.parse(newFiberGettingController.text);
      Provider.of<MealsData>(context, listen: false)
          .addMeal(mealName, calories, carbs, protein, fats, fiber);
      clear();
  }

  //Helper to clear all the controllers in the page
  void clear() {
    mealNameGettingController.clear();
    newCalorieGettingController.clear();
    newCarbGettingController.clear();
    newProteinGettingController.clear();
    newFatGettingController.clear();
    newFiberGettingController.clear();
  }

  //The meal page to add a meal in
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Consumer<MealsData>(
      builder: (context, value, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.blueAccent.shade400,
            title: Text(widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontStyle: FontStyle.italic,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: height * 0.06,
                  bottom: height * 0.03,
                  right: 0,
                  left: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            bottom: 17,
                          ),
                          child: Text("Meal Name",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 35,
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            bottom: 17,
                          ),
                          child: Text("Calories",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 35,
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 22,
                            bottom: 15,
                          ),
                          child: Text("Carbs",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 35,
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 25,
                            bottom: 25,
                          ),
                          child: Text("Protein",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 35,
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                          ),
                          child: Text("Fats",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 35,
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 25,
                            bottom: 20,
                          ),
                          child: Text("Fiber",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 35,
                              )
                          ),
                        ),
                      ],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 14,
                              bottom: 14,
                            ),
                            child: SizedBox(
                              width: 150,
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: mealNameGettingController,
                                decoration: const InputDecoration(
                                  hintText: "enter the meal name",
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 14,
                              bottom: 14,
                            ),
                            child: SizedBox(
                              width: 150,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: newCalorieGettingController,
                                decoration: const InputDecoration(
                                  hintText: "enter in calories",
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 14,
                              bottom: 14,
                            ),
                            child: SizedBox(
                              width: 150,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: newCarbGettingController,
                                decoration: const InputDecoration(
                                  hintText: "enter in grams",
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 14,
                              bottom: 14,
                            ),
                            child: SizedBox(
                              width: 150,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: newProteinGettingController,
                                decoration: const InputDecoration(
                                  hintText: "enter in grams",
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 14,
                              bottom: 14,
                            ),
                            child: SizedBox(
                              width: 150,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: newFatGettingController,
                                decoration: const InputDecoration(
                                  hintText: "enter in grams",
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 14,
                              bottom: 14,
                            ),
                            child: SizedBox(
                              width: 150,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: newFiberGettingController,
                                decoration: const InputDecoration(
                                  hintText: "enter in grams",
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 100,
                  right: 100,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 8,
                      width: 0,
                    ),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: saveMeal,
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                        label: const Text('Add Meal'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      )
    );
  }
}
