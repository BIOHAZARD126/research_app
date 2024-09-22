// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_import, deprecated_member_use, avoid_print, unused_element

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;  // Import to check if the platform is web

import 'home_page.dart'; 
import 'tacs_page.dart';
import 'anxiety_module.dart';
import 'adhd_module.dart';
import 'depression_module.dart';
import 'cognitive_training_module.dart';
import 'sleep_improvement_module.dart';
import 'ptsd_module.dart';
import 'autism_module.dart';
import 'stress_management_module.dart';
import 'procrastination_module.dart';
import 'alzheimers_module.dart';
import 'sign_in_screen.dart';
import 'audio_visual_page.dart';
import 'camera_module.dart';
import 'consent_form_screen.dart';
import 'eegpage.dart';
import 'exercise_widget.dart';
import 'face_detection_util.dart';
import 'firebase_firestore.dart';
import 'module_prompt.dart';
import 'mss_page.dart';
import 'neuro_nanotech_page.dart';
import 'profilepage.dart';
import 'sensor_module.dart';
import 'video_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // Initialize Firebase for Web
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "your-api-key",
        authDomain: "your-auth-domain",
        projectId: "your-project-id",
        storageBucket: "your-storage-bucket",
        messagingSenderId: "your-messaging-sender-id",
        appId: "your-app-id",
        measurementId: "your-measurement-id",
      ),
    );
  } else {
    // Initialize Firebase for other platforms
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'research_app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationWrapper(),
      routes: {
        '/anxiety': (context) => AnxietyModule(),
        '/adhd': (context) => ADHDModule(),
        '/depression': (context) => DepressionModule(),
        '/cognitive': (context) => CognitiveTrainingModule(),
        '/sleep': (context) => SleepImprovementModule(),
        '/ptsd': (context) => PTSDModule(),
        '/autism': (context) => AutismModule(),
        '/stress': (context) => StressManagementModule(),
        '/procrastination': (context) => ProcrastinationModule(),
        '/alzheimers': (context) => AlzheimersModule(),
        '/signinscreen': (context) => AuthenticationWrapper(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _showExitPrompt(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Home Page Content'),
              ElevatedButton(
                onPressed: () async {
                  UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
                  print("User signed in: ${userCredential.user?.uid}");
                },
                child: Text('Sign in Anonymously'),
              ),
              ElevatedButton(
                onPressed: () async {
                  CollectionReference users = FirebaseFirestore.instance.collection('users');
                  await users.add({'name': 'John Doe', 'age': 30});
                  print("User added to Firestore");
                },
                child: Text('Add User to Firestore'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> _showExitPrompt(BuildContext context) async {
  bool exit = false;
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Exit App'),
      content: Text('Do you want to exit directly or give a review before exiting?'),
      actions: [
        TextButton(
          onPressed: () {
            exit = true;
            Navigator.of(context).pop();
          },
          child: Text('Exit Directly'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            _showReviewPrompt(context);
          },
          child: Text('Give Review and Exit'),
        ),
      ],
    ),
  );
  return exit;
}

Future<void> _showReviewPrompt(BuildContext context) async {
  TextEditingController reviewController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Give Review'),
      content: TextField(
        controller: reviewController,
        decoration: InputDecoration(hintText: 'Enter your review here'),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('user_review', reviewController.text);
            Fluttertoast.showToast(msg: 'Review submitted');
            Navigator.of(context).pop();
            Navigator.of(context).pop(true); // Exit the app
          },
          child: Text('Enter Review and Exit'),
        ),
      ],
    ),
  );
}
