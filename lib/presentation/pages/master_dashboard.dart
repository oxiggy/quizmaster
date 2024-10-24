import 'package:flutter/material.dart';

class MasterDashboardPage extends StatelessWidget {
  const MasterDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: Center(
        child: Text('Dashboard'),
      ),
    );
  }
}