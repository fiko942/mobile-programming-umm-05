import 'package:flutter/cupertino.dart';
import 'pages/counter_page.dart';
import 'pages/about_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // High Sierra-inspired colors
  static const Color _accentBlue = Color(0xFF007AFF); // classic macOS/iOS blue
  static const Color _windowBg = Color(0xFFF2F2F2); // light window gray
  static const Color _barBg = Color(0xFFF8F8F8);
  static const Color _separator = Color(0x33000000); // subtle separator (20% black)

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'High Sierra Style',
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: _accentBlue,
        barBackgroundColor: _barBg,
        scaffoldBackgroundColor: _windowBg,
      ),
      home: const _RootTabs(),
    );
  }
}

class _RootTabs extends StatelessWidget {
  const _RootTabs();

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: theme.barBackgroundColor.withValues(alpha: 0.95),
        activeColor: theme.primaryColor,
        inactiveColor: const Color(0x8A000000),
        border: const Border(top: BorderSide(color: MyApp._separator, width: 0.5)),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add),
            label: 'Counter',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.info),
            label: 'About',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const CupertinoTabView(builder: _buildCounterPage);
          case 1:
          default:
            return const CupertinoTabView(builder: _buildAboutPage);
        }
      },
    );
  }

  static Widget _buildCounterPage(BuildContext context) => const CounterPage();
  static Widget _buildAboutPage(BuildContext context) => const AboutPage();
}

