// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';
import 'face_detection_util.dart'; // Import the face detection utility

class AutismModule extends StatefulWidget {
  @override
  _AutismModuleState createState() => _AutismModuleState();
}

class _AutismModuleState extends State<AutismModule> {
  late CameraController _controller;
  bool _isCameraInitialized = false;
  String _faceDetectionResult = 'No faces detected';
  final FaceDetectionUtil _faceDetectionUtil = FaceDetectionUtil();

  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
    _controller.dispose();
    _faceDetectionUtil.dispose();
    super.dispose();
  }

  void _practiceSocialInteraction() {
    // Implement social interaction practice logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autism Spectrum Disorder Module'),
      ),
      body: Column(
        children: [
          if (_isCameraInitialized)
            CameraPreview(_controller)
          else
            Center(child: CircularProgressIndicator()),
          ElevatedButton(
            onPressed: _practiceSocialInteraction,
            child: Text('Practice Social Interaction'),
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
