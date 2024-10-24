import 'package:flutter/material.dart';

class ActiveGamesPage extends StatelessWidget {
  const ActiveGamesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Text('Active Games'),
      ),
    );
  }
}