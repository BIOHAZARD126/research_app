// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';
import 'face_detection_util.dart'; // Import the face detection utility

class DepressionModule extends StatefulWidget {
  @override
  _DepressionModuleState createState() => _DepressionModuleState();
}

class _DepressionModuleState extends State<DepressionModule> {
  late CameraController _controller;
  bool _isCameraInitialized = false;
  double _moodLevel = 0.0;
  String _faceDetectionResult = 'No faces detected';
  final FaceDetectionUtil _faceDetectionUtil = FaceDetectionUtil();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    accelerometerEventStream().listen((AccelerometerEvent event) {
      setState(() {
        _moodLevel = event.x.abs() + event.y.abs() + event.z.abs();
      });
    });
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras.first, ResolutionPreset.high);
    await _controller.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  void _detectFaces() async {
    if (_controller.value.isInitialized) {
      final imageFile = await _controller.takePicture();
      final faces = await _faceDetectionUtil.detectFaces(File(imageFile.path));
      setState(() {
        _faceDetectionResult = 'Detected ${faces.length} face(s)';
      });
    }
  }

  void _startPositiveActivities() {
    // Implement positive activities logic here
  }

  @override
  void dispose() {
    _controller.dispose();
    _faceDetectionUtil.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Depression Module'),
      ),
      body: Column(
        children: [
          if (_isCameraInitialized)
            CameraPreview(_controller)
          else
            Center(child: CircularProgressIndicator()),
          SizedBox(height: 20),
          Text(
            'Mood Level: $_moodLevel',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: _startPositiveActivities,
            child: Text('Start Positive Activities'),
          ),
          ElevatedButton(
            onPressed: _detectFaces,
            child: Text('Detect Faces'),
          ),
          Text(_faceDetectionResult),
        ],
      ),
    );
  }
}
