// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User Information Section
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/profile_picture.png'), // Placeholder for profile picture
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Name',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text('Age: 25'),
                      Text('Contact: user@example.com'),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            // Health Metrics Overview
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Health Metrics Overview',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text('Recent Brainwave Readings: Alpha, Beta'),
                  Text('Recent Neuroplasticity Activities: Virtual Labs, Games'),
                  Text('MSS Page Choices: Audio-Visual Stimulation, Haptic Feedback'),
                  Text('Biofeedback Game Results: High Score: 200, Recent Score: 180'),
                ],
              ),
            ),
            Divider(),
            // Achievements and Badges
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Achievements and Badges',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      Chip(label: Text('Badge 1')),
                      Chip(label: Text('Badge 2')),
                      Chip(label: Text('Badge 3')),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            // Activity History
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity History',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  ListTile(
                    title: Text('EEG Session'),
                    subtitle: Text('Date: 2024-07-04'),
                  ),
                  ListTile(
                    title: Text('Neuroplasticity Game'),
                    subtitle: Text('Date: 2024-07-03'),
                  ),
                ],
              ),
            ),
            Divider(),
            // Progress Tracker
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progress Tracker',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  // Placeholder for progress chart/graph
                  Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Center(child: Text('Progress Chart')),
                  ),
                ],
              ),
            ),
            Divider(),
            // Favorite Exercises and Activities
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Favorite Exercises and Activities',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  ListTile(
                    title: Text('Meditation Exercise'),
                    trailing: Icon(Icons.favorite, color: Colors.red),
                  ),
                  ListTile(
                    title: Text('Brainwave Visualization'),
                    trailing: Icon(Icons.favorite, color: Colors.red),
                  ),
                ],
              ),
            ),
            Divider(),
            // Personal Notes and Journals
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Notes and Journals',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  // Placeholder for notes and journals
                  Container(
                    height: 100,
                    color: Colors.grey[300],
                    child: Center(child: Text('Notes and Journals')),
                  ),
                ],
              ),
            ),
            Divider(),
            // Settings Shortcut
            Container(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to settings page
                },
                child: Text('Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
