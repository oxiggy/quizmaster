import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State {
  var _loading = true;
  final _usernameController = TextEditingController();
  late String _userName;

  @override
  void initState() {
    _loadProfile();
    super.initState();
  }

  Future<void> _loadProfile() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;
      final data = (await Supabase.instance.client
          .from('roles')
          .select()
          .match({'id': '310abccb-3434-4410-b427-5cdf01528d29'}).maybeSingle());
      if (data != null) {
        setState(() {
          _usernameController.text = data['name'];
          _userName = data['name'];
        });
        print('Username: $_userName');
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_userName ?? 'Unknown user'),
        backgroundColor: Colors.blue,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error occurred while getting profile'),
        backgroundColor: Colors.red,
      ));
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
      ? const Center(child: CircularProgressIndicator())
      : Column(
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              label: Text('Username'),
            ),
          ),
        ],
      );
  }
}