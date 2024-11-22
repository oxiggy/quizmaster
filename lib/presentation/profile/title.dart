import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget {
  const TitleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Starter',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}