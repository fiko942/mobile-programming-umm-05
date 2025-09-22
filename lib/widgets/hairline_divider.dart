import 'package:flutter/cupertino.dart';

class HairlineDivider extends StatelessWidget {
  const HairlineDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      color: const Color(0x33000000),
      width: double.infinity,
    );
  }
}
