import 'package:flutter/material.dart';

class Friend {
  final int id;
  final String name;
  final String avatarUrl;

  Friend({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });
}

final List<Friend> mockFriends = [
  Friend(
    id: 1,
    name: 'Alice',
    avatarUrl: 'https://via.placeholder.com/150/FF5733',
  ),
  Friend(
    id: 2,
    name: 'Bob',
    avatarUrl: 'https://via.placeholder.com/150/33FF57',
  ),
  Friend(
    id: 3,
    name: 'Charlie',
    avatarUrl: 'https://via.placeholder.com/150/3357FF',
  ),
  Friend(
    id: 4,
    name: 'Diana',
    avatarUrl: 'https://via.placeholder.com/150/FF33A1',
  ),
];

class FriendsPreviewCard extends StatelessWidget {
  final List<Friend> friends;

  FriendsPreviewCard({required this.friends});

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
              'Friends',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Column(
              children: friends
                  .take(3)
                  .map((friend) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(friend.avatarUrl),
                        ),
                        title: Text(friend.name),
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
