import 'package:flutter/cupertino.dart';
// no extra imports needed
import '../theme_controller.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: appThemeNotifier,
      builder: (context, isDramatic, _) {
        final color = CupertinoTheme.of(context).primaryColor;
        return GestureDetector(
          onTap: () => appThemeNotifier.value = !isDramatic,
          child: SizedBox(
            width: 48,
            height: 40, // larger touch area so moon glyph isn't clipped
            child: Center(
              child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 240),
                firstChild: Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Icon(CupertinoIcons.sun_max, color: color, size: 20),
                ),
                secondChild: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Icon(CupertinoIcons.moon, color: color, size: 20),
                ),
                crossFadeState: isDramatic ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                firstCurve: Curves.easeOut,
                secondCurve: Curves.easeOut,
                sizeCurve: Curves.easeInOut,
              ),
            ),
          ),
        );
      },
    );
  }
}
