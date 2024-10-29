import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmaster/core/models/session.dart';

class LogoutButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        shadowColor: Colors.teal,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      ),
        onPressed: () async {
          await Provider.of<AuthProvider>(context, listen: false).logout();
        },
      child: Text('Logout'),
    );
  }
}