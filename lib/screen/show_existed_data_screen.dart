import 'package:flutter/material.dart';

import '../model/existed_item_model.dart';
import '../widget/show_widget/icon_button_widget.dart';
import '../widget/show_widget/isExpendables_widget.dart';
import '../widget/upload_widget/show_text_widget.dart';

class ShowExistedDataScreen extends StatefulWidget {
  final ExistedItemModel model;
  late Function settingHome;

  ShowExistedDataScreen({
    super.key,
    required this.model,
    required this.settingHome,
  });

  @override
  State<ShowExistedDataScreen> createState() => _ShowExistedDataScreenState();
}

class _ShowExistedDataScreenState extends State<ShowExistedDataScreen> {
  late String name = widget.model.name; //물품명
  late int count = widget.model.count;
  late int bundle = widget.model.bundle; //개수
  late int isExpendables = widget.model.isExpendables; // 소모품인지 비품인지 구분하는 변수
  late String sort = widget.model.sort; //물품의 종류(식품, 생필품, 공구 등)
  late String broadLocation = widget.model.broadLocation; //넓은 범위 위치(의료과학관)
  late String narrowLocation = widget.model.narrowLocation; // 좁은 범위 위치(1521호)
  late String detailLocation = widget.model.detailLocation; // 디테일한 위치(누구 책상 위)
  late String note = widget.model.note; //비고

  void setShowScreen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: const Color.fromARGB(255, 55, 61, 79),
            centerTitle: true,
            title: const Text(
              'Existed Item',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
//=================================물품명(name)=================================
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    ShowTextWidget(
                      textContent: '물품명',
                      contentFontSize: 20,
                    ),
                    const SizedBox(width: 25),
                    ShowTextWidget(
                      textContent: name,
                      contentFontSize: 16,
                    ),
                  ],
                ),
//=================================종류(sort)===================================
                const SizedBox(height: 10),
                Row(
                  children: [
                    ShowTextWidget(
                      textContent: '종류',
                      contentFontSize: 20,
                    ),
                    const SizedBox(width: 45),
                    ShowTextWidget(
                      textContent: sort,
                      contentFontSize: 16,
                    ),
                  ],
                ),
//========================개수(count, bundle)===================================
                const SizedBox(height: 10),
                Row(
                  children: [
                    ShowTextWidget(
                      textContent: '개수',
                      contentFontSize: 20,
                    ),
                    const SizedBox(width: 47),
                    ShowTextWidget(
                      textContent: '$count개 ${bundle}Set',
                      contentFontSize: 16,
                    ),
                  ],
                ),
//=============위치(boardLocation, narrowLocation, detailLocation)==============
                const SizedBox(height: 10),
                Row(
                  children: [
                    ShowTextWidget(
                      textContent: '위치',
                      contentFontSize: 20,
                    ),
                    const SizedBox(width: 47),
                    ShowTextWidget(
                      textContent: broadLocation,
                      contentFontSize: 16,
                    ),
                    const SizedBox(width: 10),
                    ShowTextWidget(
                      textContent: narrowLocation,
                      contentFontSize: 16,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 85),
                    ShowTextWidget(
                      textContent: detailLocation,
                      contentFontSize: 16,
                    ),
                  ],
                ),
//===================소모품(expendableIcon, fixturesIcon)=======================
                const SizedBox(height: 20),
                isExpendables == 1
                    ? IsExpendableWidget(
                        expendableIcon: Icons.check_box_outlined,
                        fixturesIcon: Icons.check_box_outline_blank,
                      )
                    : IsExpendableWidget(
                        expendableIcon: Icons.check_box_outline_blank,
                        fixturesIcon: Icons.check_box_outlined,
                      ),
                const SizedBox(height: 20),
//==============================비고(note)======================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShowTextWidget(
                      textContent: '비고',
                      contentFontSize: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: 300,
                  height: 240,
                  decoration: BoxDecoration(border: Border.all()),
                  child: ShowTextWidget(
                    textContent: note,
                    contentFontSize: 16,
                  ),
                ),
              ],
            ),
          ),
//===========================최하단 아이콘 버튼=================================
          Row(
            children: [
              const SizedBox(width: 50),
              isExpendables == 1
                  ? IconButtonWidget(
                      screen: 'Show',
                      settingShow: setShowScreen,
                      settingHome: widget.settingHome,
                      iconAction: 'minusItem',
                      model: widget.model,
                      usingState: widget.model.isUsing,
                      selectedIcon: Icons.remove_circle)
                  : IconButtonWidget(
                      screen: 'Show',
                      settingShow: setShowScreen,
                      settingHome: widget.settingHome,
                      iconAction: 'useItem',
                      model: widget.model,
                      usingState: widget.model.isUsing,
                      selectedIcon: Icons.person_pin),
              IconButtonWidget(
                  screen: 'Show',
                  settingShow: setShowScreen,
                  settingHome: widget.settingHome,
                  iconAction: 'updateItem',
                  model: widget.model,
                  usingState: widget.model.isUsing,
                  selectedIcon: Icons.edit),
              IconButtonWidget(
                  screen: 'Show',
                  settingShow: setShowScreen,
                  settingHome: widget.settingHome,
                  iconAction: 'deleteItem',
                  usingState: widget.model.isUsing,
                  model: widget.model,
                  selectedIcon: Icons.delete),
            ],
          )
        ],
      ),
    );
  }
}
