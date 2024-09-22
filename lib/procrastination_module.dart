// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';
import 'face_detection_util.dart'; // Import the face detection utility

class ProcrastinationModule extends StatefulWidget {
  @override
  _ProcrastinationModuleState createState() => _ProcrastinationModuleState();
}

class _ProcrastinationModuleState extends State<ProcrastinationModule> {
  double _taskProgress = 0.0;
  late CameraController _controller;
  bool _isCameraInitialized = false;
  String _faceDetectionResult = 'No faces detected';
  final FaceDetectionUtil _faceDetectionUtil = FaceDetectionUtil();

  @override
  void initState() {
    super.initState();
    accelerometerEventStream().listen((AccelerometerEvent event) {
      setState(() {
        _taskProgress += event.x.abs() + event.y.abs() + event.z.abs();
      });
    });
    _initializeCamera();
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

  void _startTask() {
    // Implement task logic here
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
        title: Text('Procrastination Module'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Task Progress: $_taskProgress',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startTask,
              child: Text('Start Task'),
            ),
            if (_isCameraInitialized)
              CameraPreview(_controller)
            else
              Center(child: CircularProgressIndicator()),
            ElevatedButton(
              onPressed: _detectFaces,
              child: Text('Detect Faces'),
            ),
            Text(_faceDetectionResult),
          ],
        ),
      ),
    );
  }
}
