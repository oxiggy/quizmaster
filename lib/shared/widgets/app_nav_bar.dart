import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      showUnselectedLabels: false,
      unselectedItemColor:Theme.of(context).colorScheme.onSurface,
      selectedItemColor: Theme.of(context).colorScheme.secondary,
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
    );
  }
}