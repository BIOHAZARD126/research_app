// ignore_for_file: use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'module_prompt.dart';
import 'video_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TACSPAGE extends StatelessWidget {
  final String backendUrl = 'http://127.0.0.1:5000';

  const TACSPAGE({super.key}); // Update with your backend URL if different

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('tACS Biofeedback Games'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildModuleButton(
              context,
              'Anxiety Module',
              'assets/images/anxiety.png',
              'Anxiety',
            ),
            _buildModuleButton(
              context,
              'ADHD Module',
              'assets/images/adhd.png',
              'ADHD',
            ),
            _buildModuleButton(
              context,
              'Depression Module',
              'assets/images/depression.png',
              'Depression',
            ),
            _buildModuleButton(
              context,
              'Cognitive Training Module',
              'assets/images/cognitive.png',
              'CognitiveTraining',
            ),
            _buildModuleButton(
              context,
              'Sleep Improvement Module',
              'assets/images/sleep.png',
              'SleepImprovement',
            ),
            _buildModuleButton(
              context,
              'PTSD Module',
              'assets/images/ptsd.png',
              'PTSD',
            ),
            _buildModuleButton(
              context,
              'Autism Module',
              'assets/images/autism.png',
              'Autism',
            ),
            _buildModuleButton(
              context,
              'Stress Management Module',
              'assets/images/stress.png',
              'StressManagement',
            ),
            _buildModuleButton(
              context,
              'Procrastination and Motivation Module',
              'assets/images/procrastination.png',
              'ProcrastinationMotivation',
            ),
            _buildModuleButton(
              context,
              'Alzheimer\'s and Dementia Module',
              'assets/images/alzheimers.png',
              'AlzheimersDementia',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleButton(BuildContext context, String label, String imagePath, String module) {
    return ElevatedButton(
      onPressed: () => _handleModulePress(context, module),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 80),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

Future<void> _handleModulePress(BuildContext context, String module) async {
    if (module == 'CognitiveTraining' || module == 'Autism' || module == 'ProcrastinationMotivation') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ModulePrompt(
            moduleName: module,
            sentences: [], // Add the appropriate value for sentences
            selectedVoice: 'default', // Add the appropriate value for selectedVoice
          ),
        ),
      );
    } else {
      final response = await http.post(
        Uri.parse('$backendUrl/process_video'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'module': module}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final videoUrl = data['video_url'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPage(
              filePath: videoUrl,
              sentences: 'Welcome to the module; Let us start', // Add the appropriate value for sentences
              moduleName: module,
              selectedVoice: 'default', // Add the appropriate value for selectedVoice
            ),
          ),
        );
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load video for $module module')),
        );
      }
    }
  }}