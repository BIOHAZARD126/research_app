// ignore_for_file: use_super_parameters, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VideoPage extends StatefulWidget {
  final String moduleName;
  final String sentences;
  final String selectedVoice;
  final String traumaWord;

  const VideoPage({
    Key? key,
    required this.moduleName,
    required this.sentences,
    required this.selectedVoice,
    this.traumaWord = '', required filePath,
  }) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchAndPlayVideo();
  }

  Future<void> _fetchAndPlayVideo() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/process_video'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'module_name': widget.moduleName,
        'sentences': widget.sentences,
        'selected_voice': widget.selectedVoice,
        'trauma_word': widget.traumaWord,
      }),
    );

    if (response.statusCode == 200) {
      final videoUrl = jsonDecode(response.body)['video_url'];
      _controller = VideoPlayerController.networkUrl(videoUrl)
        ..initialize().then((_) {
          setState(() {
            _isLoading = false;
          });
          _controller.play();
          _controller.setLooping(true);
        });
    } else {
      setState(() {
        _error = 'Failed to load video';
        _isLoading = false;
      });
    }
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
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else if (_error != null)
            Center(child: Text(_error!))
          else
            SizedBox.expand(
              child: _controller.value.isInitialized
                  ? VideoPlayer(_controller)
                  : Container(color: Colors.black),
            ),
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
