import 'package:flutter/material.dart';

import '../../shared/widgets/loading_dots.dart';

class AuthOnboardingPage extends StatefulWidget {
  const AuthOnboardingPage({Key? key}) : super(key: key);

  @override
  _AuthOnboardingPageState createState () => _AuthOnboardingPageState();
}

class _AuthOnboardingPageState extends State<AuthOnboardingPage> {
  late final _usernameController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: _loading
        ? const Center(child: LoadingDots())
        : SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Давай познакомимся', style: TextStyle(fontSize: 24)),
                      const SizedBox(height: 40),
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(labelText: 'Username'),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _loading = true;
                          });
                        },
                        child: const Text('Начнём!'),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                )
              )
            )
          )
      )
    );
  }
}