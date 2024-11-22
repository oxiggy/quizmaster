import 'dart:math';
import 'package:flutter/material.dart';

class LevelInfo extends StatefulWidget {
  @override
  _LevelInfoState createState() => _LevelInfoState();
}

class _LevelInfoState extends State<LevelInfo> {
  final _nextLevelExp = 100;
  final List<String> _levelTitles = [
    "Novice Explorer", "Curious Mind", "Rising Star", "Bright Learner", "Fresh Thinker",
    "Puzzle Seeker", "Explorer of Ideas", "Rookie Challenger", "Knowledge Spark", "Aspiring Master",
    "Clever Strategist", "Wisdom Collector", "Problem Solver", "Trailblazer", "Quiz Challenger",
    "Sharp Thinker", "Knowledge Adventurer", "Fast Learner", "Puzzle Master", "Trivia Seeker",
    "Knowledge Maverick", "Enlightened Mind", "Wisdom Keeper", "Elite Challenger", "Quiz Tactician",
    "Mastermind", "Quiz Warrior", "Trivia Titan", "Champion of Minds", "The Legend"
  ];

  int _experience = 0;
  int _level = 1;
  String _levelTitle = "";

  @override
  void initState() {
    super.initState();
    _generateRandomValue();
  }

  void _generateRandomValue() {
    final random = Random();
    setState(() {
      _experience = random.nextInt(100);
      _level = random.nextInt(30);
      _levelTitle = _levelTitles[_level];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RichText(text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: _levelTitle, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
                TextSpan(text: '  ($_level lvl)', style: const TextStyle(fontSize: 20, color: Colors.grey)),
            ]
            )),
            const SizedBox(height: 16),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 20.0,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: _experience / _nextLevelExp,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 20.0,
                      width: double.infinity,
                      color: Colors.teal[300]!,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            //Text('$_experience / $_nextLevelExp'),
          ],
        ),
      ),
    );
  }
}