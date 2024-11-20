import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  Future<void> createUser(String id, String nickname) async {

    try {
    await Supabase.instance.client
        .from('users')
        .insert({'id': id, 'nickname': nickname});
    } catch (e) {
      print('Ошибка создания пользователя: $e');
      throw Exception('Ошибка создания пользователя: ${e.toString()}');
    }
  }
}