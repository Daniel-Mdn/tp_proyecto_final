import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigatorBarWidget extends StatefulWidget {
  const BottomNavigatorBarWidget({super.key});

  @override
  State<BottomNavigatorBarWidget> createState() =>
      _BottomNavigatorBarWidgetState();
}

class _BottomNavigatorBarWidgetState extends State<BottomNavigatorBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String currentUrl = GoRouterState.of(context).uri.toString();

    // Mapeo de rutas a índices
    int getCurrentIndex(String route) {
      if (route.startsWith('/gestiones')) return 0;
      if (route.startsWith('/home')) return 1;
      if (route.startsWith('/alimentacion')) return 2;
      return -1; // Si no coincide con ninguna pestaña, no se resalta ninguna
    }

    int currentIndex = getCurrentIndex(currentUrl);

    void onTap(BuildContext context, int value) {
      switch (value) {
        case 0:
          GoRouter.of(context).go('/gestiones');
          break;
        case 1:
          GoRouter.of(context).go('/home');
          break;
        case 2:
          GoRouter.of(context).go('/alimentacion');
          break;
      }
    }

    return BottomNavigationBar(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: theme.colorScheme.onSurface,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.description),
          icon: Icon(Icons.description_outlined),
          label: 'Mis gestiones',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.menu_book),
          icon: Icon(Icons.menu_book_outlined),
          label: 'Alimentación',
        ),
      ],
      onTap: (value) => onTap(context, value),
    );
  }
}
