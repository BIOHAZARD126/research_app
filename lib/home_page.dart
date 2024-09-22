// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'mss_page.dart';
import 'exercise_widget.dart'; // Import the ExerciseWidget

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  int _selectedIndex = 1; // Default to home page which is now at index 1
  bool _showExerciseWidget = false;

  static const List<Widget> _pages = <Widget>[
    MSSPage(), // MSSPage with headphone icon
    HomePageContent(),
    SettingsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/app_vid.mp4")
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
    _showExerciseWidget = true; // Show exercise widget initially
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _showExerciseWidget = false; // Hide exercise widget after 5 seconds
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : Container(color: Colors.black),
          ),
          if (_showExerciseWidget)
            ExerciseWidget(onSkip: () {
              setState(() {
                _showExerciseWidget = false;
              });
            }),
          if (!_showExerciseWidget)
            _pages[_selectedIndex],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.headphones), label: "MSS"), // MSS tab
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "Home"), // Home tab
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings"), // Settings tab
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"), // Profile tab
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder widget for home page content
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home Page Content'));
  }
}

// Placeholder widget for settings page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Settings Page'));
  }
}

// Placeholder widget for profile page
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Page'));
  }
}
