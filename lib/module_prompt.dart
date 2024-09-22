// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'video_page.dart';

class ModulePrompt extends StatefulWidget {
  final String moduleName;
  final bool isVideoModule;

  const ModulePrompt({super.key, required this.moduleName, this.isVideoModule = false, required List sentences, required String selectedVoice});

  @override
  _ModulePromptState createState() => _ModulePromptState();
}

class _ModulePromptState extends State<ModulePrompt> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _traumaController = TextEditingController();
  String? selectedVoice;
  final List<String> voiceOptions = [
    'Young Male',
    'Young Female',
    'Teen Male',
    'Teen Female',
    'Adult Male',
    'Adult Female',
    'Old Male',
    'Old Female'
  ];

  @override
  void dispose() {
    _textController.dispose();
    _traumaController.dispose();
    super.dispose();
  }

  Future<void> playTTS(String text) async {
    await flutterTts.setVoice({'name': selectedVoice ?? 'default', 'locale': 'en-US'});
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.moduleName} Module'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (widget.moduleName == 'PTSD') ...[
              TextField(
                controller: _traumaController,
                decoration: const InputDecoration(
                  labelText: 'Explain what gave you trauma, phobia or PTSD but only in one word.',
                ),
              ),
              const SizedBox(height: 20),
            ],
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: "Enter those comforting sentences that you always wanted to hear from your loved one but couldn't.",
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose the voice below nearest to the voice of your loved one.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ...voiceOptions.map((voice) => ListTile(
              title: Text(voice),
              leading: Radio<String>(
                value: voice,
                groupValue: selectedVoice,
                onChanged: (value) {
                  setState(() {
                    selectedVoice = value;
                  });
                  playTTS('Hello there');
                },
              ),
            )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget.isVideoModule) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPage(
                        moduleName: widget.moduleName,
                        sentences: _textController.text,
                        selectedVoice: selectedVoice!,
                        traumaWord: _traumaController.text, filePath: null,
                      ),
                    ),
                  );
                } else {
                  // Handle other module functionality
                }
              },
              child: const Text('Select'),
            ),
          ],
        ),
      ),
    );
  }
}
