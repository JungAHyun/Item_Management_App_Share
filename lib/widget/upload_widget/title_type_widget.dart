import 'package:flutter/cupertino.dart';

//물품명, 종류 등등 같은 제목 적는 곳
class TitletypeWidget extends StatelessWidget {
  const TitletypeWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 2, 6),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            //fontFamily: 'Explora-Regular',
          ),
        ),
      ],
    );
  }
}
