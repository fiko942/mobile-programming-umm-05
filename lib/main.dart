import 'package:flutter/cupertino.dart';
import 'pages/counter_page.dart';
import 'pages/about_page.dart';
import 'theme_controller.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Classic High Sierra palette
  static const Color _accentBlue = Color(0xFF007AFF);
  static const Color _windowBg = Color(0xFFF2F2F2);
  static const Color _barBg = Color(0xFFF8F8F8);
  static const Color _separator = Color(0x33000000);

  // Dramatic alternative palette (dark, purple accent)
  static const Color _dramaticAccent = Color(0xFF9B59B6);
  static const Color _dramaticBg = Color(0xFF0F0B1A);
  static const Color _dramaticBar = Color(0xFF120D22);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: appThemeNotifier,
      builder: (context, dramatic, _) {
        final theme = dramatic
            ? CupertinoThemeData(
                brightness: Brightness.dark,
                primaryColor: _dramaticAccent,
                scaffoldBackgroundColor: _dramaticBg,
                barBackgroundColor: _dramaticBar,
                textTheme: const CupertinoTextThemeData(
                  textStyle: TextStyle(color: CupertinoColors.white),
                ),
              )
            : const CupertinoThemeData(
                brightness: Brightness.light,
                primaryColor: _accentBlue,
                scaffoldBackgroundColor: _windowBg,
                barBackgroundColor: _barBg,
              );

        return CupertinoApp(
          debugShowCheckedModeBanner: false,
          title: 'High Sierra Style',
          theme: theme,
          home: const _RootTabs(),
        );
      },
    );
  }
}

class _RootTabs extends StatefulWidget {
  const _RootTabs();

  @override
  State<_RootTabs> createState() => _RootTabsState();
}

class _RootTabsState extends State<_RootTabs> {
  @override
  void initState() {
    super.initState();
    appThemeNotifier.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    appThemeNotifier.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: theme.barBackgroundColor.withOpacity(0.95),
        activeColor: theme.primaryColor,
        inactiveColor: theme.brightness == Brightness.dark ? const Color(0x66FFFFFF) : const Color(0x8A000000),
        border: Border(top: BorderSide(color: theme.brightness == Brightness.dark ? const Color(0x33FFFFFF) : MyApp._separator, width: 0.5)),
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

