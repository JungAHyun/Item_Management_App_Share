import 'package:flutter/material.dart';

import '../../model/existed_item_model.dart';
import '../../screen/show_existed_data_screen.dart';
import '../show_widget/icon_button_widget.dart';

class ExistedItemWidget extends StatelessWidget {
  //ListView의 item인 ExistedItemModel을 파라미터로 받음
  //ShowExistedDataScreen에서 아이콘버튼 클릭 시 HomeScreen을 새로고침하기 위해 settingHome을 파라미터로 받음
  late ExistedItemModel model;
  late Function settingHome;

  ExistedItemWidget({
    super.key,
    required this.model,
    required this.settingHome,
  });

  @override
  Widget build(BuildContext context) {
    //item 클릭 시,  ShowExistedDataScreen으로 이동함
    //ShowExistedDataScreen 스크린에서 DB 정보를 수정하고, HomeScreen에 적용해야 함
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => ShowExistedDataScreen(
                  model: model,
                  settingHome: settingHome,
                )),
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              offset: const Offset(3, 3),
              color: Colors.black.withOpacity(0.2),
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        height: 100,
        width: 360,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 25,
          ),
          child: Row(
            children: [
              //=========================물품 이름==============================
              Center(
                child: SizedBox(
                  width: 100,
                  child: Text(
                    model.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 55, 61, 79),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              //=========================개수, 위치=============================
              SizedBox(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.count}개 ${model.bundle}Set',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 55, 61, 79),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${model.broadLocation} ${model.narrowLocation} ${model.detailLocation}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 55, 61, 79),
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              //====================아이콘(소모품/비품)=========================
              model.isExpendables == 1
                  ? IconButtonWidget(
                      screen: 'Home',
                      settingHome: settingHome,
                      iconAction: 'minusItem',
                      model: model,
                      usingState: model.isUsing,
                      selectedIcon: Icons.remove_circle)
                  : IconButtonWidget(
                      screen: 'Home',
                      settingHome: settingHome,
                      iconAction: 'useItem',
                      model: model,
                      usingState: model.isUsing,
                      selectedIcon: Icons.person_pin),
            ],
          ),
        ),
      ),
    );
  }
}
