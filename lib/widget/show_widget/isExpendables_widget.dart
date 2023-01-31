import 'package:flutter/material.dart';

import '../upload_widget/title_type_widget.dart';

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
        const TitletypeWidget(title: '소모품'),
        const SizedBox(width: 10),
        Icon(
          expendableIcon,
          color: const Color.fromARGB(255, 55, 61, 79),
          size: 40,
        ),
        const SizedBox(width: 20),
        const TitletypeWidget(title: '비품'),
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
