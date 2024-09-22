// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'dart:math';

class NeuroNanotechPage extends StatefulWidget {
  @override
  _NeuroNanotechPageState createState() => _NeuroNanotechPageState();
}

class _NeuroNanotechPageState extends State<NeuroNanotechPage> {
  Offset particlePosition = Offset(100, 100);
  Offset targetPosition = Offset(300, 300);
  List<Offset> obstacles = [];
  Random random = Random();

  @override
  void initState() {
    super.initState();
    generateObstacles();
  }

  void generateObstacles() {
    for (int i = 0; i < 10; i++) {
      obstacles.add(Offset(random.nextDouble() * 400, random.nextDouble() * 600));
    }
  }

  void moveParticle(Offset direction) {
    setState(() {
      particlePosition += direction;

      // Check collision with obstacles
      for (var obstacle in obstacles) {
        if ((particlePosition - obstacle).distance < 20) {
          // Handle collision
          showGameOverDialog();
          return;
        }
      }

      // Check if particle reached target
      if ((particlePosition - targetPosition).distance < 20) {
        // Handle reaching target
        showSuccessDialog();
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text('You crashed into an obstacle!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: Text('Try Again'),
          ),
        ],
      ),
    );
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('You reached the target!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: Text('Play Again'),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      particlePosition = Offset(100, 100);
      targetPosition = Offset(random.nextDouble() * 400, random.nextDouble() * 600);
      obstacles.clear();
      generateObstacles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neuro-Enhancing Nanotechnology'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Virtual Labs: Neuroplasticity Steps',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '1. Introduction to Neuroplasticity\n'
                '2. Understanding Neural Pathways\n'
                '3. Impact of Nanotechnology on Brain Function\n'
                '4. Virtual Experiments on Neuroplasticity\n'
                '5. Interactive Learning Modules\n',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NeuroNanotechGame()),
                  );
                },
                child: Text('Start Interactive Journey'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NeuroNanotechGame extends StatefulWidget {
  @override
  _NeuroNanotechGameState createState() => _NeuroNanotechGameState();
}

class _NeuroNanotechGameState extends State<NeuroNanotechGame> {
  Offset particlePosition = Offset(100, 100);
  Offset targetPosition = Offset(300, 300);
  List<Offset> obstacles = [];
  Random random = Random();

  @override
  void initState() {
    super.initState();
    generateObstacles();
  }

  void generateObstacles() {
    for (int i = 0; i < 10; i++) {
      obstacles.add(Offset(random.nextDouble() * 400, random.nextDouble() * 600));
    }
  }

  void moveParticle(Offset direction) {
    setState(() {
      particlePosition += direction;

      // Check collision with obstacles
      for (var obstacle in obstacles) {
        if ((particlePosition - obstacle).distance < 20) {
          // Handle collision
          showGameOverDialog();
          return;
        }
      }

      // Check if particle reached target
      if ((particlePosition - targetPosition).distance < 20) {
        // Handle reaching target
        showSuccessDialog();
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text('You crashed into an obstacle!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: Text('Try Again'),
          ),
        ],
      ),
    );
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('You reached the target!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: Text('Play Again'),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      particlePosition = Offset(100, 100);
      targetPosition = Offset(random.nextDouble() * 400, random.nextDouble() * 600);
      obstacles.clear();
      generateObstacles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neuro-Enhancing Nanotech Game'),
      ),
      body: Stack(
        children: [
          Positioned(
            left: particlePosition.dx,
            top: particlePosition.dy,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: targetPosition.dx,
            top: targetPosition.dy,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
          for (var obstacle in obstacles)
            Positioned(
              left: obstacle.dx,
              top: obstacle.dy,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () => moveParticle(Offset(-10, 0)),
                  child: Icon(Icons.arrow_left),
                ),
                ElevatedButton(
                  onPressed: () => moveParticle(Offset(10, 0)),
                  child: Icon(Icons.arrow_right),
                ),
                ElevatedButton(
                  onPressed: () => moveParticle(Offset(0, -10)),
                  child: Icon(Icons.arrow_upward),
                ),
                ElevatedButton(
                  onPressed: () => moveParticle(Offset(0, 10)),
                  child: Icon(Icons.arrow_downward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
