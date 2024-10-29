import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/models/session.dart';
import '../widgets/logout_button.dart';

class AuthPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Auth Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                final password = _passwordController.text.trim();
                try {
                  await Supabase.instance.client.auth.signUp(
                    email: email,
                    password: password,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('User signed up successfully!'),
                    backgroundColor: Colors.greenAccent,
                  ));
                } catch(e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Sign up failed'),
                    backgroundColor: Colors.red,
                  ));
                  print('Error: $e');
                }
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  await authProvider.login(_emailController.text.trim(), _passwordController.text.trim());
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('User signed in successfully!'),
                    backgroundColor: Colors.greenAccent,
                  ));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('$e'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: const Text('Sign In'),
            ),
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return authProvider.isAuthenticated ? LogoutButton() : const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}