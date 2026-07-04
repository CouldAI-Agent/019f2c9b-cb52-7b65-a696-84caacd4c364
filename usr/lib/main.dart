import 'package:flutter/material.dart';
import 'screens/emulator_screen.dart';
import 'screens/theory_screen.dart';
import 'screens/resources_screen.dart';

void main() {
  runApp(const TenEmulatorApp());
}

class TenEmulatorApp extends StatelessWidget {
  const TenEmulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ten Emulator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF0F0F17),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A24),
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainLayout(),
        '/emulator': (context) => const EmulatorScreen(),
        '/theory': (context) => const TheoryScreen(),
        '/resources': (context) => const ResourcesScreen(),
      },
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const EmulatorScreen(),
    const TheoryScreen(),
    const ResourcesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              backgroundColor: const Color(0xFF1A1A24),
              selectedIndex: _currentIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.hub_outlined),
                  selectedIcon: Icon(Icons.hub),
                  label: Text('Emulator'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.menu_book_outlined),
                  selectedIcon: Icon(Icons.menu_book),
                  label: Text('Theory'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.link_outlined),
                  selectedIcon: Icon(Icons.link),
                  label: Text('Resources'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1, color: Colors.black26),
            Expanded(child: _screens[_currentIndex]),
          ],
        ),
      );
    }

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF1A1A24),
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.hub_outlined),
            selectedIcon: Icon(Icons.hub),
            label: 'Emulator',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Theory',
          ),
          NavigationDestination(
            icon: Icon(Icons.link_outlined),
            selectedIcon: Icon(Icons.link),
            label: 'Resources',
          ),
        ],
      ),
    );
  }
}
