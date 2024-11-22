import 'package:flutter/material.dart';

class History {
  final String title;
  final String date;
  final String gameStatus; //finished, canceled
  final bool isWinner;

  History({
    required this.title,
    required this.date,
    required this.gameStatus,
    required this.isWinner,
  });
}

final List<History> mockHistory = [
  History(
    title: 'Brain Quest Challenge',
    date: '10 minutes ago',
    gameStatus: 'finished',
    isWinner: false,
  ),
  History(
    title: 'Trivia Titans',
    date: '3 hours ago',
    gameStatus: 'finished',
    isWinner: true,
  ),
  History(
    title: 'Mind Maze',
    date: 'Today',
    gameStatus: 'canceled',
    isWinner: false,
  ),
  History(
    title: 'Quick Wit Quiz',
    date: 'Yesterday',
    gameStatus: 'finished',
    isWinner: false,
  ),
  History(
    title: 'Fact Frenzy',
    date: 'November 21',
    gameStatus: 'finished',
    isWinner: false,
  ),
];

class HistoryCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          const Text(
            'History',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Column(
            children: mockHistory
                .take(3)
                .map((item) => ListTile(
              leading: const Icon(Icons.check, size: 32),
              title: Text(item.title),
              subtitle: Text(item.date),
            ))
                .toList(),
          ),
        ],
      )
    );
  }
}



