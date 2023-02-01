import 'package:flutter/material.dart';

import '../upload_widget/show_text_widget.dart';

class IsExpendableWidget extends StatelessWidget {
  late IconData expendableIcon; // Icons.check_box_outlined
  late IconData fixturesIcon;

  IsExpendableWidget({
    super.key,
    required this.expendableIcon,
    required this.fixturesIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShowTextWidget(
          textContent: '소모품',
          contentFontSize: 20,
        ),
        const SizedBox(width: 10),
        Icon(
          expendableIcon,
          color: const Color.fromARGB(255, 55, 61, 79),
          size: 40,
        ),
        const SizedBox(width: 20),
        ShowTextWidget(
          textContent: '비품',
          contentFontSize: 20,
        ),
        const SizedBox(width: 10),
        Icon(
          fixturesIcon,
          color: const Color.fromARGB(255, 55, 61, 79),
          size: 40,
        ),
      ],
    );
  }
}
