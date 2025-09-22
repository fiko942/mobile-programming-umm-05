import 'package:flutter/cupertino.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  void _increment() => setState(() => _count++);
  void _reset() => setState(() => _count = 0);

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Counter'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Text(
                'Count',
                style: theme.textTheme.textStyle.copyWith(
                  color: const Color(0x99000000),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$_count',
                style: theme.textTheme.navLargeTitleTextStyle.copyWith(
                  fontSize: 56,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton.filled(
                    onPressed: _increment,
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                    child: const Icon(CupertinoIcons.add, size: 22, color: CupertinoColors.white),
                  ),
                  const SizedBox(width: 12),
                  CupertinoButton(
                    onPressed: _reset,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
