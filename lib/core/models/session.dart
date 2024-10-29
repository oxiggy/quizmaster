import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  String? _accessToken;
  String? _refreshToken;

  bool get isAuthenticated => _accessToken != null;

  AuthProvider() {
    _loadSession();
  }

  Future<void> _loadSession() async {
    _accessToken = await _storage.read(key: 'access_token');
    _refreshToken = await _storage.read(key: 'refresh_token');
    if (_accessToken != null) {
      await _validateSession();
    }
  }

  // Ключ listen: false отключает отслеживание изменений, так как для таких действий, как login или logout,
  // нам не нужно обновление интерфейса. Это повышает производительность, предотвращая лишние перерисовки виджетов
  // при изменении состояния провайдера.
  Future<void> login(String email, String password) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        _accessToken = response.session?.accessToken;
        _refreshToken = response.session?.refreshToken;
        await _saveSession();
        notifyListeners();
      } else {
        throw Exception('Ошибка входа: неверные учетные данные.');
      }
    } catch (e) {
      print('Ошибка входа: $e');
      throw Exception('Ошибка входа: ${e.toString()}');
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.session != null) {
        _accessToken = response.session?.accessToken;
        _refreshToken = response.session?.refreshToken;
        await _saveSession();
        notifyListeners();
      } else {
        throw Exception('Ошибка регистрации');
      }
    } catch (e) {
      print('Ошибка входа: $e');
      throw Exception('Ошибка входа: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
    _accessToken = null;
    _refreshToken = null;
    await _clearSession();
    notifyListeners();
  }

  Future<void> _validateSession() async {
    try {
      if (_accessToken != null) {
        final user = await Supabase.instance.client.auth.getUser(_accessToken!);
        if (user == null) await _refreshSession();
      }
    } catch (_) {
      await _refreshSession();
    }
  }

  Future<void> _refreshSession() async {
    try {
      final response = await Supabase.instance.client.auth.refreshSession();

      if (response.session != null) {
        _accessToken = response.session?.accessToken;
        _refreshToken = response.session?.refreshToken;
        await _saveSession();
        notifyListeners();
      } else {
        throw Exception('Ошибка обновления сессии');
      }
    } catch (e) {
      print('Ошибка обновления сессии: $e');
      await logout();
    }
  }

  Future<void> _saveSession() async {
    await _storage.write(key: 'access_token', value: _accessToken);
    await _storage.write(key: 'refresh_token', value: _refreshToken);
  }

  Future<void> _clearSession() async {
    await _storage.deleteAll();
  }
}