import 'package:flutter/material.dart';

class AppLoadingPage extends StatelessWidget {
  const AppLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('App Loading Page'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}