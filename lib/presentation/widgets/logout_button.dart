import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmaster/core/models/session.dart';

class LogoutButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout),
      onPressed: () async {
        await Provider.of<AuthProvider>(context, listen: false).logout();
      },
    );
  }
}