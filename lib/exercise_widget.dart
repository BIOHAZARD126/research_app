// exercise_widget.dart file :
// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseWidget extends StatefulWidget {
  final VoidCallback onSkip;

  ExerciseWidget({required this.onSkip});

  @override
  _ExerciseWidgetState createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  int _currentLevel = 1;
  int _selectedLevel = 0; // Define _selectedLevel variable

  @override
  void initState() {
    super.initState();
    _loadUserProgress();
  }

  _loadUserProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentLevel = (prefs.getInt('currentLevel') ?? 1);
    });
  }

  _saveUserProgress(int level) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentLevel', level);
  }

  List<Map<String, String>> exercises = [
    {
      "title": "Finger Tapping",
      "instructions": "Tap each finger to your thumb in sequence (index, middle, ring, pinky) and then reverse the order. Repeat this for 5 minutes with both hands."
    },
    {
      "title": "Finger Opposites",
      "instructions": "Spin your index fingers in opposite directions. Start by drawing circles in the air with both index fingers, one clockwise and the other counterclockwise. Practice for 5 minutes."
    },
    {
      "title": "Cross-Crawl Exercise",
      "instructions": "While standing, lift your right knee and touch it with your left elbow. Alternate with the left knee and right elbow. Perform this exercise for 5 minutes to stimulate coordination."
    },
    {
      "title": "Eye Tracking",
      "instructions": "Hold a pen at arm's length and move it slowly in different directions (up, down, left, right, diagonals) while keeping your head still and following the pen with your eyes. Do this for 5 minutes."
    },
    {
      "title": "Figure Eights",
      "instructions": "Use your right hand to draw a large figure eight in the air. Once comfortable, use your left hand. Then, try doing it with both hands simultaneously. Perform this exercise for 5 minutes."
    },
    {
      "title": "Marching in Place with Arm Swings",
      "instructions": "March in place while swinging your arms. Try to swing your right arm forward as you lift your left leg, and vice versa. Continue for 5 minutes to enhance motor coordination."
    },
    {
      "title": "Opposite Limb Movements",
      "instructions": "Stand on one leg and extend the opposite arm forward while extending the other leg backward. Hold for a few seconds, then switch sides. Repeat for 5 minutes."
    },
    {
      "title": "Alternating Toe Touches",
      "instructions": "Stand with your feet shoulder-width apart. Bend at the waist and touch your right hand to your left foot, then return to standing and touch your left hand to your right foot. Perform this exercise for 5 minutes."
    },
    {
      "title": "Bilateral Drawing",
      "instructions": "Hold a pen in each hand and draw a circle with one hand and a square with the other simultaneously. Practice for 5 minutes, switching shapes and hands to challenge your brain."
    },
    {
      "title": "Spinning Plates",
      "instructions": "Imagine spinning a plate on the tip of each finger. Start with one hand, then the other. Once comfortable, try 'spinning' two plates at the same time with both hands. Perform this exercise for 5 minutes."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return _currentLevel <= exercises.length
        ? Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Level $_currentLevel: ${exercises[_currentLevel - 1]['title']}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(exercises[_currentLevel - 1]['instructions']!),
                  SizedBox(height: 20),
                  if (_currentLevel <= exercises.length) ...[
                    ElevatedButton(
                      onPressed: () {
                        _showRatingDialog(context);
                      },
                      child: Text("I can do it."),
                    ),
                    ElevatedButton(
                      onPressed: widget.onSkip,
                      child: Text("Skip to the app"),
                    ),
                  ] else
                    Text(
                      "Oh no! Even the developer isn't as fast as you to make more Levels. You're the Flash !! You're Lightning McQueen !!!",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          )
        : Container();
  }

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Rate your speed"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("On a scale of 1 to 10, where 1 is I can barely do it slow and 10 is I am speed, rate how fast you can do the countermanding exercise."),
              SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: List<Widget>.generate(10, (index) {
                  return ChoiceChip(
                    label: Text((index + 1).toString()),
                    selected: _selectedLevel == index + 1,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedLevel = selected ? index + 1 : 0;
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _currentLevel++;
                  _saveUserProgress(_currentLevel);
                });
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}
