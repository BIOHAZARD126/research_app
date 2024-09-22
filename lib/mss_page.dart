import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import 'video_page.dart';

class MSSPage extends StatelessWidget {
  const MSSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Sensory Stimulation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Vibration Patterns',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildPatternButton(
                    context,
                    'Steady Calm Pulse',
                    () => _vibratePattern([0, 1000, 1000]),
                  ),
                  _buildPatternButton(
                    context,
                    'Heartbeat Mimic',
                    () => _vibratePattern([0, 100, 100, 200, 500]),
                  ),
                  _buildPatternButton(
                    context,
                    'Wave Pattern',
                    () => _vibratePattern([0, 500, 500, 1000, 500, 1500, 500, 1000, 500]),
                  ),
                  _buildPatternButton(
                    context,
                    'Randomized Gentle Pulses',
                    () => _vibratePattern([0, 200, 300, 200, 300, 200, 400, 200]),
                  ),
                  _buildPatternButton(
                    context,
                    'Low Frequency (20-30 Hz)',
                    () => _vibratePattern([0, 50, 450, 50, 450]),
                  ),
                  _buildPatternButton(
                    context,
                    'Medium Frequency (30-60 Hz)',
                    () => _vibratePattern([0, 30, 470, 30, 470]),
                  ),
                  _buildPatternButton(
                    context,
                    'Deep Pressure Simulation',
                    () => _vibratePattern([0, 1000, 1000, 1000]),
                  ),
                  _buildPatternButton(
                    context,
                    'Om Sound Mimic',
                    () => _vibratePattern([0, 1000, 500, 1000]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Solo-Audio Options',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildAudioButton(context, 'Rain', 'assets/audio/rain.mp3'),
                  _buildAudioButton(context, 'Forest Birds', 'assets/audio/forest birds.mp3'),
                  _buildAudioButton(context, 'Wind Chimes', 'assets/audio/wind chimes.mp3'),
                  _buildAudioButton(context, 'Pain Relief and Anesthesia', 'assets/audio/174 Hz - Pain Relief and Anesthesia.mp3'),
                  _buildAudioButton(context, 'Healing and Tissue Regeneration', 'assets/audio/285 Hz - Healing and Tissue Regeneration.mp3'),
                  _buildAudioButton(context, 'Undoing Situations and Facilitating Change', 'assets/audio/417 Hz - Undoing Situations and Facilitating Change.mp3'),
                  _buildAudioButton(context, 'Transformation and Miracles (DNA Repair)', 'assets/audio/528 Hz - Transformation and Miracles (DNA Repair).mp3'),
                  _buildAudioButton(context, 'Connecting Relationships', 'assets/audio/639 Hz - Connecting(or)Relationships.mp3'),
                  _buildAudioButton(context, 'Awakening Intuition and Consciousness Expansion', 'assets/audio/741 Hz - Awakening Intuition and Consciousness Expansion.mp3'),
                  _buildAudioButton(context, 'Returning to Spiritual Order', 'assets/audio/852 Hz - Returning to Spiritual Order.mp3'),
                  _buildAudioButton(context, 'Awaken Perfect State and Divine Consciousness', 'assets/audio/963 Hz - Awaken Perfect State and Divine Consciousness.mp3'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Audio-Visual Options',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildVideoButton(context, 'Nature', 'assets/videos/forest.mp4'),
                  _buildVideoButton(context, 'Ocean', 'assets/videos/ocean.mp4'),
                  _buildVideoButton(context, 'Sky', 'assets/videos/sky.mp4'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatternButton(BuildContext context, String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAudioButton(BuildContext context, String label, String filePath) {
    return ElevatedButton(
      onPressed: () {
        // Code to play the audio file
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildVideoButton(BuildContext context, String label, String filePath) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VideoPage(filePath: filePath, moduleName: '', sentences: '', selectedVoice: '',)),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }

  void _vibratePattern(List<int> pattern) {
    Vibration.vibrate(pattern: pattern);
  }
}
