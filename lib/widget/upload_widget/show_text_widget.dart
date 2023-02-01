import 'package:flutter/cupertino.dart';

///텍스트 적을 때 사용
class ShowTextWidget extends StatelessWidget {
  ShowTextWidget(
      {super.key,
      required this.textContent,
      required this.contentFontSize,
      contentFontWeight});

  final String textContent;
  final double contentFontSize;
  var contentFontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      textContent,
      style: TextStyle(
        color: const Color.fromARGB(255, 0, 2, 6),
        fontSize: contentFontSize,
        fontWeight: contentFontWeight,
        //fontFamily: 'Explora-Regular',
      ),
    );
  }
}
