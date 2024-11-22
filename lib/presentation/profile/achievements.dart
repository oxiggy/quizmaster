import 'package:flutter/material.dart';

class Achievement {
  final int id;
  final IconData icon;
  final String title;
  final String description;

  Achievement({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
  });
}

final List<Achievement> mockAchievements = [
  Achievement(
    id: 1,
    icon: Icons.emoji_events,
    title: 'Win a Game',
    description: 'Achieved by winning a single game.',
  ),
  Achievement(
    id: 2,
    icon: Icons.sports_esports,
    title: 'Play 10 Games',
    description: 'Achieved by playing 10 games.',
  ),
  Achievement(
    id: 3,
    icon: Icons.quiz,
    title: 'Answer 50+ Questions',
    description: 'Achieved by playing a game with 50+ questions.',
  ),
];

class AchievementsPreviewCard extends StatelessWidget {
  final List<Achievement> achievements;

  AchievementsPreviewCard({required this.achievements});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Achievements',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Column(
              children: achievements
                  .take(3)
                  .map((achievement) => ListTile(
                leading: Icon(achievement.icon, size: 32),
                title: Text(achievement.title),
                subtitle: Text(achievement.description),
              ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
