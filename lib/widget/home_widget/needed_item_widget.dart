import 'package:flutter/material.dart';

import '../../model/needed_item_model.dart';
import '../../screen/show_needed_data_screen.dart';
import '../show_widget/icon_button_widget.dart';

class NeededItemWidget extends StatelessWidget {
  //ListView의 item인 NeededItemModel을 파라미터로 받음
  //ShowNeededDataScreen에서 아이콘버튼 클릭 시 HomeScreen을 새로고침하기 위해 settingHome을 파라미터로 받음
  late NeededItemModel model;
  late Function settingHome;

  NeededItemWidget({
    super.key,
    required this.model,
    required this.settingHome,
  });

  @override
  Widget build(BuildContext context) {
    //item 클릭 시,  ShowNeededDataScreen으로 이동함
    //ShowNeededDataScreen 스크린에서 DB 정보를 수정하고, HomeScreen에 적용해야 함
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => ShowNeededDataScreen(
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
                      model.reason,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 55, 61, 79),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              //===========================아이콘===============================
              IconButtonWidget(
                  screen: 'Home',
                  settingHome: settingHome,
                  usingState: 0,
                  iconAction: 'buyItem',
                  model: model,
                  selectedIcon: Icons.credit_score),
            ],
          ),
        ),
      ),
    );
  }
}
