// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AnxietyModule extends StatefulWidget {
  @override
  _AnxietyModuleState createState() => _AnxietyModuleState();
}

class _AnxietyModuleState extends State<AnxietyModule> {
  double _relaxationLevel = 0.0;
  Color _bgColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    accelerometerEventStream().listen((AccelerometerEvent event) {
      setState(() {
        _relaxationLevel = event.x.abs() + event.y.abs() + event.z.abs();
        _bgColor = (_relaxationLevel < 2) ? Colors.green : Colors.blue;
      });
    });
  }

  void _startCalmingVisuals() {
    // Implement calming visuals logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anxiety Module'),
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: _bgColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Relaxation Level: $_relaxationLevel',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startCalmingVisuals,
                child: Text('Start Calming Visuals'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
