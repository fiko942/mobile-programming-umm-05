import 'package:flutter/cupertino.dart';

/// Global theme controller for a simple two-state dramatic theme toggle.
/// false => Classic High Sierra (light). true => Dramatic Dark/Purple theme.
final ValueNotifier<bool> appThemeNotifier = ValueNotifier<bool>(false);
