// ignore_for_file: unused_element, deprecated_member_use, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'dart:async';
import 'package:vibration/vibration.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:noise_meter/noise_meter.dart';
import 'dart:math' as math;

class EEGPage extends StatefulWidget {
  const EEGPage({super.key});

  @override
  _EEGPageState createState() => _EEGPageState();
}

class _EEGPageState extends State<EEGPage> {
  List<FlSpot> brainwaveData = [];
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  final NoiseMeter _noiseMeter = NoiseMeter();
  StreamSubscription<NoiseReading>? _noiseSubscription;
  Timer? _timer;
  bool _isCollecting = false;
  bool _showAnimation = true;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _startAnimation();
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _gyroscopeSubscription?.cancel();
    _noiseSubscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    await Permission.microphone.request();
    await Permission.sensors.request();
  }

  void _startAnimation() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          Vibration.vibrate(pattern: [100, 200, 100, 500]);
          _showAnimation = false;
        });
        _showUserInstruction();
      }
    });
  }

  void _showUserInstruction() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Place Phone at Back of Head'),
        content: const Text('Touch your phone to the back of your head for EEG readings.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _startSensorDataCollection();
              _startMicrophoneRecording();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _startSensorDataCollection() {
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      _processSensorData(event.x, event.y, event.z);
    });

    _gyroscopeSubscription = gyroscopeEvents.listen((event) {
      _processSensorData(event.x, event.y, event.z);
    });

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        double x = timer.tick.toDouble();
        double y = math.sin(timer.tick / 10) * _generateRandomNoise();
        brainwaveData.add(FlSpot(x, y));

        if (brainwaveData.length > 50) {
          brainwaveData.removeAt(0);
        }
      });
    });
  }

  void _startMicrophoneRecording() {
    try {
      _noiseSubscription = _noiseMeter.noise.listen(
        (NoiseReading noiseReading) {
          if (_isCollecting) {
            double noiseLevel = noiseReading.meanDecibel;
            _processMicrophoneData(noiseLevel);
          }
        },
        onError: (Object error) {
          print(error);
        },
        cancelOnError: true,
      );
      setState(() {
        _isCollecting = true;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _stopMicrophoneRecording() {
    _noiseSubscription?.cancel();
    setState(() {
      _isCollecting = false;
    });
  }

  void _processSensorData(double x, double y, double z) {
    // Placeholder for processing accelerometer and gyroscope data
  }

  void _processMicrophoneData(double noiseLevel) {
    // Placeholder for processing microphone data
  }

  double _generateRandomNoise() {
    return Random().nextDouble();
  }

  List<FlSpot> _amplifyAndProcessData(List<FlSpot> data) {
    // Amplify and process the collected data
    return data.map((spot) => FlSpot(spot.x, spot.y * 10)).toList();
  }

  void _sendToMachineLearningModels(List<FlSpot> data) {
    // Placeholder for sending data to machine learning models
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> processedData = _amplifyAndProcessData(brainwaveData);
    _sendToMachineLearningModels(processedData);

    return Scaffold(
      appBar: AppBar(
        title: const Text('EEG Page'),
      ),
      body: _showAnimation
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: processedData,
                          isCurved: true,
                          barWidth: 2,
                          color: Colors.blue,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.blue.withOpacity(0.3),
                          ),
                        ),
                      ],
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: false),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Real-time Brainwave Visualization',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
    );
  }
}
