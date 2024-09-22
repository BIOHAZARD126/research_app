// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AudioVisualPage extends StatefulWidget {
  final String videoPath;
  final List<String> sentences;
  final String selectedVoice;

  const AudioVisualPage({super.key, 
    required this.videoPath,
    required this.sentences,
    required this.selectedVoice,
  });

  @override
  _AudioVisualPageState createState() => _AudioVisualPageState();
}

class _AudioVisualPageState extends State<AudioVisualPage> {
  late VideoPlayerController _controller;
  final FlutterTts flutterTts = FlutterTts();
  final bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });

    _playSentences();
  }

  @override
  void dispose() {
    _controller.dispose();
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _playSentences() async {
    await flutterTts.setVoice({"name": widget.selectedVoice, "locale": "en-US"});
    for (String sentence in widget.sentences) {
      await flutterTts.speak(sentence);
      await Future.delayed(const Duration(seconds: 5)); // Adjust delay as needed
    }
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
          Positioned(
            top: 40,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Exit'),
            ),
          ),
        ],
      ),
    );
  }
}
