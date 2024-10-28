import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quizmaster/presentation/pages/active_games.dart';
import 'package:quizmaster/presentation/pages/auth.dart';
import 'package:quizmaster/presentation/pages/game.dart';
import 'package:quizmaster/presentation/pages/game_list.dart';
import 'package:quizmaster/presentation/pages/master_dashboard.dart';
import 'package:quizmaster/presentation/pages/profile.dart';
import 'package:quizmaster/presentation/pages/statistics.dart';
import 'package:quizmaster/presentation/pages/users.dart';
import 'package:quizmaster/shared/widgets/app_nav_bar.dart';

enum UserRole { guest, player, master, admin }

// Пример текущей роли пользователя (для теста можно менять значение)
UserRole currentUserRole = UserRole.guest;

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/games',
    routes: [
      GoRoute(
        path: '/auth',
        name: 'AuthPage',
        builder: (context, state) => AuthPage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: _buildRoutesForRole(currentUserRole),
      ),
    ],
  );
}

// Функция, создающая роуты для каждой роли
List<GoRoute> _buildRoutesForRole(UserRole role) {
  switch (role) {
    case UserRole.guest:
      return [
        GoRoute(
          path: '/games',
          name: 'GameList',
          builder: (context, state) => GameListPage(),
        ),
        GoRoute(
          path: '/game',
          name: 'Game',
          builder: (context, state) => _redirectToAuthIfGuest(context),
        ),
        GoRoute(
          path: '/profile',
          name: 'Profile',
          builder: (context, state) => ProfilePage(),
        ),
      ];
    case UserRole.player:
      return [
        GoRoute(
          path: '/games',
          name: 'GameList',
          builder: (context, state) => GameListPage(),
        ),
        GoRoute(
          path: '/game',
          name: 'Game',
          builder: (context, state) => GamePage(),
        ),
        GoRoute(
          path: '/profile',
          name: 'Profile',
          builder: (context, state) => ProfilePage(),
        ),
      ];
    case UserRole.master:
      return [
        GoRoute(
          path: '/master-dashboard',
          name: 'MasterDashboard',
          builder: (context, state) => MasterDashboardPage(),
        ),
        GoRoute(
          path: '/games',
          name: 'GameList',
          builder: (context, state) => GameListPage(),
        ),
        GoRoute(
          path: '/game',
          name: 'Game',
          builder: (context, state) => GamePage(),
        ),
        GoRoute(
          path: '/profile',
          name: 'Profile',
          builder: (context, state) => ProfilePage(),
        ),
      ];
    case UserRole.admin:
      return [
        GoRoute(
          path: '/games',
          name: 'GameList',
          builder: (context, state) => GameListPage(),
        ),
        GoRoute(
          path: '/active-games',
          name: 'ActiveGames',
          builder: (context, state) => ActiveGamesPage(),
        ),
        GoRoute(
          path: '/users',
          name: 'Users',
          builder: (context, state) => UsersPage(),
        ),
        GoRoute(
          path: '/statistics',
          name: 'Statistics',
          builder: (context, state) => StatisticsPage(),
        ),
        GoRoute(
          path: '/profile',
          name: 'Profile',
          builder: (context, state) => ProfilePage(),
        ),
      ];
    default:
      return [];
  }
}

// Логика перенаправления на AuthPage, если пользователь гость
Widget _redirectToAuthIfGuest(BuildContext context) {
  if (currentUserRole == UserRole.guest) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go('/auth'); // Редирект на страницу авторизации
    });
    return SizedBox(); // Пустой виджет, так как будет редирект
  } else {
    return GamePage(); // Если не гость, показываем страницу Game
  }
}

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({required this.child});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  List<String> _routes = [];

  @override
  void initState() {
    super.initState();
    _routes = _getRoutesForRole(currentUserRole);
  }

  List<String> _getRoutesForRole(UserRole role) {
    switch (role) {
      case UserRole.guest:
        return ['/games', '/game', '/profile'];
      case UserRole.player:
        return ['/games', '/game', '/profile'];
      case UserRole.master:
        return ['/master-dashboard', '/games', '/game', '/profile'];
      case UserRole.admin:
        return ['/games', '/active-games', '/users', '/statistics', '/profile'];
      default:
        return ['/games'];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: _getBottomNavigationItems(currentUserRole),
      ),
    );
  }

  List<BottomNavigationBarItem> _getBottomNavigationItems(UserRole role) {
    switch (role) {
      case UserRole.guest:
        return const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: 'Play'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ];
      case UserRole.player:
        return const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: 'Play'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ];
      case UserRole.master:
        return const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: 'Play'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ];
      case UserRole.admin:
        return const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Active Games'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Statistics'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ];
      default:
        return const [];
    }
  }
}