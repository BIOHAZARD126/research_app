// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class PTSDModule extends StatefulWidget {
  @override
  _PTSDModuleState createState() => _PTSDModuleState();
}

class _PTSDModuleState extends State<PTSDModule> {
  double _stressLevel = 0.0;
  Color _bgColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    accelerometerEventStream().listen((AccelerometerEvent event) {
      setState(() {
        _stressLevel = event.x.abs() + event.y.abs() + event.z.abs();
        _bgColor = (_stressLevel < 2) ? Colors.green : Colors.blue;
      });
    });
  }

  void _startGroundingExercise() {
    // Implement grounding exercise logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PTSD Module'),
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: _bgColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Stress Level: $_stressLevel',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startGroundingExercise,
                child: Text('Start Grounding Exercise'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
