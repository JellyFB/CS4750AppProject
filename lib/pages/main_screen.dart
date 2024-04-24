import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/time_widget.dart';
import '../meals/hive_database.dart';
import '../meals/meal_data.dart';
import 'add_meal_page.dart';
import 'bmi_calculator.dart';
import 'past_meals_page.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //Initializing the database to store and read data
  @override
  void initState() {
    super.initState();

    Provider.of<MealsData>(context, listen: false).initializeMealList();

  }

  //Database reference variable to store information (such as calorie goal)
  final db = HiveDataBase();

  //Total calorie goal initially set and saved to the database
  double totalCalories = 2000;

  // Obtaining the information from the text field for CALORIE GOAL
  final newCalorieGoalController = TextEditingController();

  // Pop up menu to set the calorie goal
  void setCalorieGoal() {
    showDialog(context: context,
        builder: (context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text("Set your calorie goal!"),
          content: TextField(
            keyboardType: TextInputType.number,
            controller: newCalorieGoalController,
            decoration: const InputDecoration(
              hintText: 'Automatically set to 2000',
            )
          ),
          actions: [
          //Saving the value
          MaterialButton(
            onPressed: () {
              setState(() {
                //Does nothing if the value is less than or equal to 0
                if (double.parse(newCalorieGoalController.text) <= 0) {
                    showDialog(context: context,
                        builder: (context) => AlertDialog(
                          actionsAlignment: MainAxisAlignment.center,
                          content: const Text("Invalid value! Please enter a positive value",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  )
                                             ),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Ok", style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ))
                            )
                          ]
                        )
                    );
                }
                else {
                  //Obtaining the calorie goal and saving it to database
                  totalCalories = double.parse(newCalorieGoalController.text);
                  Navigator.pop(context);
                  newCalorieGoalController.clear();
                  db.saveCalorieToDataBase(totalCalories);
                }
                });
            },
            child: const Text("Save", style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ))
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              newCalorieGoalController.clear();
            },
            child: const Text("Cancel", style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                )
                ),
          )
          ],
        ),
    );
  }

  //Traversing to different pages on the app
  void _onItemTapped(int index) {
    // Brings you to the BMI page
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BMICalculator(title: 'Calculate Your BMI')),
      );
    }
    // Setting calorie goal page
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddMealPage(title: 'Add Your Meal')),
      );
    }
    // More additional information in diets page
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PastMealPage(title: 'Past Added Meals')),
      );
    }
  }

  //Main page with all the necessary information presented
  @override
  Widget build(BuildContext context) {
    //Creating the size of the box based upon the height of the phone
    final height = MediaQuery.of(context).size.height;

    return Consumer<MealsData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        centerTitle: true,
        title: Text(widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              height: height * 0.38,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(35)
                ),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //Displays the current date
                          const CurrentDateWidget(),
                          //Radial Widget insert Progress of the amount of calories consumed
                          SizedBox(
                            width: 300,
                            height: 220,
                              child: SfRadialGauge(
                                  axes: <RadialAxis>[
                                    RadialAxis(
                                      minimum: 0,
                                      maximum: db.readingCalorieFromDatabase(),
                                      showLabels: false,
                                      showTicks: false,
                                      axisLineStyle: const AxisLineStyle(
                                        thickness: 0.3,
                                        cornerStyle: CornerStyle.bothCurve,
                                        color: Color.fromARGB(30, 0, 169, 181),
                                        thicknessUnit: GaugeSizeUnit.factor,
                                      ),
                                      pointers: <GaugePointer>[
                                        RangePointer(
                                          //Dynamically changing the value based upon how many meals are present and added
                                          value: value.mealList.fold<double>(0, (sum, item) => sum + item.calories),
                                          cornerStyle: CornerStyle.bothCurve,
                                          width: 0.3,
                                          sizeUnit: GaugeSizeUnit.factor,
                                        )
                                      ],

                                    ),
                                  ],
                              ),
                          ),
                          //Displays the amount of calories consumed over the
                          //          total amount of calories
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Total Calories: ${value.mealList.fold<double>(0, (sum, item) => sum + item.calories)} / "
                                  "${db.readingCalorieFromDatabase()}",
                                style: const TextStyle(wordSpacing: 2.5,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                ),
                              ),
                            ]
                          )
                        ]
                      )
                    ]
                  )
                ),
              ),
            ),

            //Setting calorie goal button and text
            Positioned(
              top: height * 0.38,
              left: 0,
              right: 0,
              child: SizedBox(
                height: height,
                child: Column(
                  children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                        bottom: 2,
                       ),
                      child: CupertinoButton(
                        color: Colors.blueAccent,
                        onPressed: setCalorieGoal,
                        child: const Text("Set Calorie Goal",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ]
                )
                )
        ),

            //The macros of all the meals that have been added
            Positioned(
              top: height * 0.45,
              left: 0,
              right: 0,
              child: SizedBox (
                height: height,
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Text(
                        "Macros Consumed Today",
                        style: TextStyle(color: Colors.blueGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //Categories
                            const Padding(
                              padding: EdgeInsets.only(
                                bottom: 2,
                                left: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text("Carbs:   ",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold
                                          )
                                        ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(8),
                                      child: Text("Protein: ",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold
                                        )
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(8),
                                      child: Text("Fats:    ",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold
                                        )
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(8),
                                      child: Text("Fiber:   ",
                                        style: TextStyle(
                                           fontSize: 30,
                                           fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                            ),
                            //Amounts
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 2,
                                right: 10,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 5,
                                        top: 5,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                        child: Container(
                                          color: Colors.blueGrey.shade100,
                                          child: SizedBox(
                                              height: 50,
                                              width: 225,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text("${value.mealList.fold<double>(0, (sum, item) => sum + item.carbs)}",
                                                      style: TextStyle(
                                                        fontSize: 35,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.blue.shade800,
                                                      )
                                                  )
                                                ]
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 5,
                                        top: 5,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                        child: Container(
                                          color: Colors.blueGrey.shade100,
                                          child: SizedBox(
                                              height: 50,
                                              width: 225,
                                              child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text("${value.mealList.fold<double>(0, (sum, item) => sum + item.protein)}",
                                                        style: TextStyle(
                                                          fontSize: 35,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.blue.shade800,
                                                        )
                                                    )
                                                  ]
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 5,
                                          top: 5,
                                        ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                        child: Container(
                                          color: Colors.blueGrey.shade100,
                                          child: SizedBox(
                                              height: 50,
                                              width: 225,
                                              child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text("${value.mealList.fold<double>(0, (sum, item) => sum + item.fats)}",
                                                      style: TextStyle(
                                                        fontSize: 35,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.blue.shade800,
                                                      )
                                                    )
                                                  ]
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 5,
                                          top: 5,
                                        ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                        child: Container(
                                          color: Colors.blueGrey.shade100,
                                          child: SizedBox(
                                              height: 50,
                                              width: 225,
                                              child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text("${value.mealList.fold<double>(0, (sum, item) => sum + item.fiber)}",
                                                      style: TextStyle(
                                                        fontSize: 35,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.blue.shade800,
                                                      )
                                                    )
                                                  ]
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                            ),
                          ]
                        )
                      ),
                    ),
                  ],
                )
              ),
            ),
          ]
        ),
        //The navigation bar to go to different pages
        backgroundColor: const Color(0xFFE9E9E9),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(35)),
          child: BottomNavigationBar(
            iconSize: 30,
            selectedIconTheme: const IconThemeData(
              color: Colors.blueAccent
            ),
            unselectedIconTheme: const IconThemeData(
              color: Colors.black87
            ),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.scale_rounded),
                label: 'BMI',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart_rounded),
                label: 'Add Meals',

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded),
                label: 'Added Meals',

              ),
            ],
            currentIndex: 1,
            selectedItemColor: Colors.blueGrey.shade400,
            onTap: _onItemTapped,
          ),
        ),
      )
    );
    }
}


