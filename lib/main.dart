import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        primaryColor: Colors.teal,
      ),
      home: const InputPage(),
    );
  }
}

// Gender selection
enum Gender {
  male,
  female,
}

// Input Page
class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;

  int height = 150;
  int weight = 50;
  int age = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A0E21),
      ),

      body: Column(
        children: [

          // Gender Selection
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    child: GenderCard(
                      color: selectedGender == Gender.male
                          ? Colors.teal
                          : const Color(0xFF1D1E33),
                      icon: Icons.male,
                      label: 'Male',
                    ),
                  ),
                ),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    child: GenderCard(
                      color: selectedGender == Gender.female
                          ? Colors.teal
                          : const Color(0xFF1D1E33),
                      icon: Icons.female,
                      label: 'Female',
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Height Selection
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Height',
                    style: TextStyle(fontSize: 20),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    '${height}cm',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Slider(
                    value: height.toDouble(),
                    min: 100,
                    max: 220,
                    activeColor: Colors.orange,
                    inactiveColor: Colors.white,
                    onChanged: (double value) {
                      setState(() {
                        height = value.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // Weight and Age
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: NumberCard(
                    label: 'Weight',
                    number: weight,
                    onMinus: () {
                      setState(() {
                        if (weight > 1) weight--;
                      });
                    },
                    onPlus: () {
                      setState(() {
                        weight++;
                      });
                    },
                  ),
                ),

                Expanded(
                  child: NumberCard(
                    label: 'Age',
                    number: age,
                    onMinus: () {
                      setState(() {
                        if (age > 1) age--;
                      });
                    },
                    onPlus: () {
                      setState(() {
                        age++;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Calculate Button
          GestureDetector(
            onTap: () {
              if (selectedGender == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select Male or Female'),
                  ),
                );
                return;
              }

              double bmi = weight /
                  ((height / 100) * (height / 100));

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    bmi: bmi,
                    age: age,
                    gender: selectedGender!,
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 65,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text(
                  'CALCULATE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Gender Card Widget
class GenderCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;

  const GenderCard({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

// Weight and Age Card Widget
class NumberCard extends StatelessWidget {
  final String label;
  final int number;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const NumberCard({
    super.key,
    required this.label,
    required this.number,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 20),
          ),

          const SizedBox(height: 10),

          Text(
            '$number',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundButton(
                icon: Icons.remove,
                onPressed: onMinus,
              ),

              const SizedBox(width: 15),

              RoundButton(
                icon: Icons.add,
                onPressed: onPlus,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Round Button Widget
class RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const RoundButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0,
      fillColor: Colors.orange,
      constraints: const BoxConstraints.tightFor(
        width: 40,
        height: 40,
      ),
      shape: const CircleBorder(),
      child: Icon(icon, color: Colors.white),
    );
  }
}

// Result Page
class ResultPage extends StatelessWidget {
  final double bmi;
  final int age;
  final Gender gender;

  const ResultPage({
    super.key,
    required this.bmi,
    required this.age,
    required this.gender,
  });

  String get resultText {
    if (bmi < 18.5) {
      return 'UNDERWEIGHT';
    } else if (bmi < 25) {
      return 'NORMAL';
    } else if (bmi < 30) {
      return 'OVERWEIGHT';
    } else {
      return 'OBESE';
    }
  }

  String get interpretation {
    if (bmi < 18.5) {
      return 'Your BMI is below the normal range.';
    } else if (bmi < 25) {
      return 'Your BMI is in the normal range.';
    } else if (bmi < 30) {
      return 'Your BMI is above the normal range.';
    } else {
      return 'Your BMI is in the obese range.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Result'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A0E21),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Your Result',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1D1E33),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    resultText,
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Text(
                    bmi.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Age: $age',
                    style: const TextStyle(fontSize: 20),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      interpretation,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              height: 65,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text(
                  'RE-CALCULATE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



