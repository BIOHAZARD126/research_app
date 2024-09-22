// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorModule extends StatefulWidget {
  @override
  _SensorModuleState createState() => _SensorModuleState();
}

class _SensorModuleState extends State<SensorModule> {
  double _sensorValue = 0.0;

  @override
  void initState() {
    super.initState();
    accelerometerEventStream().listen((AccelerometerEvent event) {
      setState(() {
        _sensorValue = event.x.abs() + event.y.abs() + event.z.abs();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Module'),
      ),
      body: Center(
        child: Text(
          'Sensor Value: $_sensorValue',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
