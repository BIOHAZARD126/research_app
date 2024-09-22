// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ADHDModule extends StatefulWidget {
  @override
  _ADHDModuleState createState() => _ADHDModuleState();
}

class _ADHDModuleState extends State<ADHDModule> {
  double _focusLevel = 0.0;

  @override
  void initState() {
    super.initState();
    accelerometerEventStream().listen((AccelerometerEvent event) {
      setState(() {
        _focusLevel = event.x.abs() + event.y.abs() + event.z.abs();
      });
    });
  }

  void _startInteractiveTasks() {
    // Implement interactive tasks logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADHD Module'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Focus Level: $_focusLevel',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startInteractiveTasks,
              child: Text('Start Interactive Tasks'),
            ),
          ],
        ),
      ),
    );
  }
}
