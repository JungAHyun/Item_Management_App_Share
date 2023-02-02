import 'package:flutter/material.dart';

import '../../db_service/existed_item_db_service.dart';
import '../../db_service/needed_item_db_service.dart';
import '../../model/needed_item_model.dart';

class IconButtonWidget extends StatefulWidget {
  late IconData selectedIcon;
  late var model;
  late String iconAction;
  late int usingState;
  late int sizedBoxWidth;
  late int size;
  late String screen;

  ///홈 스크린 변경 함수
  late Function settingHome;
  late Function? settingShow;

  IconButtonWidget({
    super.key,
    required this.iconAction, //해당 아이콘을 눌렀을 때, 발생해야하는 액션의 종류 예)'buyItem' 'rejectItem' 등
    required this.selectedIcon, // 아이콘 이름
    required this.model, // 처리할 모델
    required this.settingHome,
    this.settingShow,
    required this.usingState,
    this.sizedBoxWidth = 0,
    required this.screen, //홈 스크린에서 부른 것과, Show 스크린에서 부른것을 구별하기 위한 변수(아이콘 크기조정을 위해)
  });

  @override
  State<IconButtonWidget> createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  late var dbService;
  late var sizebox_width;
  late Color useIconColor;

//DB 사용 상태 확인 변수

  late int isusing = widget.usingState;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(widget.selectedIcon),
          color: (widget.usingState == 1 && widget.iconAction == 'useItem') ? Colors.amber.shade900 : const Color.fromARGB(255, 55, 61, 79),
          iconSize: widget.screen == 'Home' ? 35 : 55,
          onPressed: () async {
            /// model is NeededItemModel일때 버튼 액션
            if (widget.model is NeededItemModel) {
              if (widget.iconAction == 'buyItem') {
                NeededItemDBService.clickBuyButton(widget.model);
                widget.screen == 'Home' ? print('') : Navigator.pop(context);
              } else if (widget.iconAction == 'deleteItem') {
                NeededItemDBService.deleteNeededItem(widget.model);
                Navigator.pop(context);
              }
            }

            ///model is ExistedItemModel일때 버튼 액션
            else {
              if (widget.iconAction == 'minusItem') {
                ExistedItemDBService.clickMinusButton(widget.model);
                widget.screen == 'Home' ? print('') : Navigator.pop(context);
              } else if (widget.iconAction == 'useItem') {
                ExistedItemDBService.clickUsingButton(widget.model);

                widget.screen == 'Home' ? print('') : Navigator.pop(context);
              } else if (widget.iconAction == 'deleteItem') {
                ExistedItemDBService.deleteExistedItem(widget.model);
                Navigator.pop(context);
              }
            }

            // widget.settingShow();
            widget.settingHome();
          },
        ),
        SizedBox(
          width: widget.screen == 'Home' ? 0 : (widget.model is NeededItemModel ? 20 : 48),
        ),
      ],
    );
  }
}
