import 'package:flutter/material.dart';

//Calculating the BMI for the User
class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key, required this.title});

  final String title;

  @override
  State<BMICalculator> createState() => _MyBMICalculatorState();
}

class _MyBMICalculatorState extends State<BMICalculator> {

  final newWeightController = TextEditingController();
  final newHeightController = TextEditingController();

  //Calculating BMI and being printed out to the app
  void printingBMI() {
    double weightBMI = double.parse(newWeightController.text);
    double heightBMI = double.parse(newHeightController.text);

    double adultBMIValue = 703 * (weightBMI / (heightBMI * heightBMI) );
    //Rounding the value to 2 decimal places by turning it into a string
    String roundedValue = adultBMIValue.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0*$'), '');

    showDialog(context: context,
      builder: (context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: const Text("Your BMI is: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            )
                         ),
        content: Text(roundedValue,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                       )
                  ),
        actions: [
          //Button to escape
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              clear();
            },
            child: const Text("Ok"),
          )
        ],
      ),
    );
  }

  //Clearing the values in the controllers
  void clear() {
    newWeightController.clear();
    newHeightController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
        children: <Widget> [
          Padding(
          padding: EdgeInsets.only(
            top: height * 0.04,
            bottom: height * 0.001,
            right: 0,
            left: 0,
          ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //The names of the text fields in a column to the left
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 22,
                          bottom: 15,
                        ),
                        child: Text("Weight",
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
                        child: Text("Height",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 35,
                            )
                        ),
                      ),
                    ]
                  ),
                  //The text fields to enter the values
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
                            keyboardType: TextInputType.number,
                            controller: newWeightController,
                            decoration: const InputDecoration(
                              hintText: "enter in lbs",
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
                            controller: newHeightController,
                            decoration: const InputDecoration(
                              hintText: "enter in inches",
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
                  )
                ],
            ),
          ),
          //BUTTON FOR CALCULATING BMI
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
                    onPressed: printingBMI,
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                    label: const Text('Calculate BMI'),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              bottom: 10,
              left: 15,
              right: 15,
            ),
            child: Text(
                '*This is not an accurate form of measuring health '
                    'but it does give some basic insight into how healthy you are.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 4,
              right: 4,
              bottom: 2,
              top: 2,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
              top: Radius.circular(35),
              bottom: Radius.circular(35)
              ),
              child: SizedBox(
                width: 370,
                height: 370,
                child: Container(
                  color: Colors.blueAccent.shade100,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Underweight", style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          )
                      ),

                      Text("BMI < 18.5", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic
                          )
                      ),

                      Text("Healthy", style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          )
                      ),

                      Text("18.5 < BMI < 24.9", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                           fontStyle: FontStyle.italic
                          )
                      ),

                      Text("Overweight", style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          )
                      ),

                      Text("25.0 < BMI < 29.9", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic
                          )
                      ),

                      Text("Obesity", style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          )
                      ),

                      Text("BMI > 30.0", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic
                          )
                      ),
                    ]
                  )
                ),
              ),
            )
          ),
        ]
      ),
    );
  }
}
