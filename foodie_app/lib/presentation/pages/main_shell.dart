import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../viewmodels/navigation_view_model.dart';
import 'feature_placeholder_page.dart';
import 'foods_page.dart';
import 'home_page.dart';

class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  static const _pages = <Widget>[
    HomePage(),
    FoodsPage(),
    FeaturePlaceholderPage(title: 'Favorites', icon: Icons.favorite_rounded),
    FeaturePlaceholderPage(title: 'Profile', icon: Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: _pages),
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x155B3B2E),
              blurRadius: 24,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: ref
              .read(navigationIndexProvider.notifier)
              .select,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.restaurant_menu_outlined),
              selectedIcon: Icon(
                Icons.restaurant_menu_rounded,
                color: AppColors.primary,
              ),
              label: 'Foods',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border_rounded),
              selectedIcon: Icon(
                Icons.favorite_rounded,
                color: AppColors.primary,
              ),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(
                Icons.person_rounded,
                color: AppColors.primary,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
