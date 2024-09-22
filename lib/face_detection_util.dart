// ignore_for_file: deprecated_member_use

import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';

class FaceDetectionUtil {
  final faceDetector = GoogleMlKit.vision.faceDetector();

  Future<List<Face>> detectFaces(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final faces = await faceDetector.processImage(inputImage);
    return faces;
  }

  void dispose() {
    faceDetector.close();
  }
}
