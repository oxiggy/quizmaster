import 'package:flutter/material.dart';
import 'package:quizmaster/core/utils/debug_utils.dart';
import '../profile/achievements.dart';
import '../profile/friends.dart';
import '../profile/history.dart';
import '../profile/level.dart';
import '../profile/statistics.dart';
//import '../profile/title.dart';
import '../profile/user_info.dart';
import '../widgets/logout_button.dart';
import '../widgets/theme_selector.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _profileAnimation;
  late Animation<Offset> _settingsAnimation;
  bool _isSettingsView = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _profileAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _settingsAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _toggleView() {
    setState(() {
      _isSettingsView = !_isSettingsView;
    });

    if (_isSettingsView) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SlideTransition(
          position: _profileAnimation,
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Profile',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: _toggleView,
                      ),
                    ],
                  ),
                  const UserInfo(),
                  const SizedBox(height: 20),
                  //TitleCard(),
                  const SizedBox(height: 20),
                  LevelInfo(),
                  const SizedBox(height: 20),
                  AchievementsPreviewCard(achievements: mockAchievements,),
                  const SizedBox(height: 20),
                  FriendsPreviewCard(friends: mockFriends),
                  const SizedBox(height: 20),
                  const StatisticsCard(),
                  const SizedBox(height: 20),
                  HistoryCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        SlideTransition(
          position: _settingsAnimation,
          child: Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: _toggleView,
                    ),
                    const Expanded(
                      child: Text(
                        'Settings',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                    ),
                    LogoutButton(),
                    //SizedBox(width: 48),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        /*Text('user form'),*/
                        /*Text('email and password form'),*/
                        const SizedBox(
                          width: double.infinity,
                          child: ThemeSelector(),
                        ),
                        /*Text('request to change roleW'),*/
                        const SizedBox(height: 8),
                        TextButton(onPressed: () { printAllSharedPreferences(); }, child: Text('Print logs')),
                        /*TextButton(onPressed: () {}, child: Text('Delete account')),*/
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Hero(
        tag: 'profile-button',
        child: Icon(Icons.person, size: 100, color: Colors.blue),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Hero(
        tag: 'settings-button',
        child: Icon(Icons.settings, size: 100, color: Colors.blue),
      ),
    );
  }
}
