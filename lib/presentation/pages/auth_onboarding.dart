import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/user_service.dart';
import '../../shared/widgets/loading_dots.dart';

class AuthOnboardingPage extends StatefulWidget {
  const AuthOnboardingPage({Key? key}) : super(key: key);

  @override
  _AuthOnboardingPageState createState () => _AuthOnboardingPageState();
}

class _AuthOnboardingPageState extends State<AuthOnboardingPage> {
  late final _usernameController = TextEditingController();
  bool _loading = false;

  Future<void> _handleSubmit() async {
    final userId = Supabase.instance.client.auth.currentUser!.id;
    final username = _usernameController.text.trim();

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Введите никнейм'), backgroundColor: Colors.red),
      );
      return;
    }

    try {
      await UserService().createUser(userId, username);
      if (!mounted) return;
      context.go('/games');
    } catch (e) {
      print('Ошибка создания пользователя: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Ошибка создания пользователя: ${e.toString()}'), backgroundColor: Colors.red),
        );
      }
    }
  }

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
                      Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: Colors.teal[300],
                          shape: BoxShape.circle,
                        ),
                        child:  CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, size: 60, color: Colors.teal[300]!),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 240,
                        child: TextField(
                          controller: _usernameController,
                          decoration:
                            InputDecoration(
                              hintText: 'Nickname',
                              filled: true,
                              fillColor: Colors.grey[50],
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.teal[700],
                          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                        ),
                        onPressed: _handleSubmit,
                        child: const Text('Начнём!', style: TextStyle(fontSize: 20)),
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