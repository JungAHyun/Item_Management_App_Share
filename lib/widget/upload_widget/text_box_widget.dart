import 'package:flutter/material.dart';

///텍스트 입력 받을 때 사용
class TextBoxWidget extends StatelessWidget {
  final String hintText, warningText; // 물품명, 예시, 아무것도 안 적으면 나오는 문장
  final double textbox_width, textbox_height;
  final TextEditingController myTextController;

  const TextBoxWidget({
    super.key,
    required this.textbox_width,
    required this.textbox_height,
    required this.hintText,
    required this.warningText,
    required this.myTextController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: textbox_width,
      height: textbox_height,
      child: TextFormField(
        controller: myTextController,
        decoration: InputDecoration(contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0), border: const OutlineInputBorder(), hintText: hintText),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return warningText;
          }
          return null;
        },
      ),
    );
  }
}
