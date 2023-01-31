import 'package:flutter/material.dart';

import '../model/needed_item_model.dart';
import '../widget/show_widget/icon_button_widget.dart';
import '../widget/show_widget/isExpendables_widget.dart';
import '../widget/upload_widget/title_type_widget.dart';

class ShowNeededDataScreen extends StatefulWidget {
  final NeededItemModel model;
  late Function settingHome;

  ShowNeededDataScreen({
    super.key,
    required this.model,
    required this.settingHome,
  });
  @override
  State<ShowNeededDataScreen> createState() => _ShowNeededDataScreenState();
}

class _ShowNeededDataScreenState extends State<ShowNeededDataScreen> {
  late String name = widget.model.name; //물품명
  late int count = widget.model.count;
  late int bundle = widget.model.bundle; //개수
  late int isExpendables = widget.model.isExpendables; // 소모품인지 비품인지 구분하는 변수
  late String sort = widget.model.sort; //물품의 종류(식품, 생필품, 공구 등)
  late String reason = widget.model.reason; //이유
  late int price = widget.model.price; // 가격

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
              'Needed Item',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    const TitletypeWidget(
                      title: '물품명',
                    ),
                    const SizedBox(width: 25),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const TitletypeWidget(
                      title: '종류',
                    ),
                    const SizedBox(width: 45),
                    Text(
                      sort,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const TitletypeWidget(title: '개수'),
                    const SizedBox(width: 47),
                    Text(
                      '$count개 ${bundle}Set',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const TitletypeWidget(title: '총 가격'),
                    const SizedBox(
                      width: 25,
                    ),
                    Text(
                      '$price',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    TitletypeWidget(title: '필요이유'),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: 300,
                  height: 240,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Text(
                    reason,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 40),
              IconButtonWidget(
                  screen: 'Show',
                  settingShow: setShowScreen,
                  settingHome: widget.settingHome,
                  usingState: 0,
                  iconAction: 'buyItem',
                  model: widget.model,
                  selectedIcon: Icons.credit_score),
              IconButtonWidget(
                  screen: 'Show',
                  settingShow: setShowScreen,
                  usingState: 0,
                  settingHome: widget.settingHome,
                  iconAction: 'rejectItem',
                  model: widget.model,
                  selectedIcon: Icons.dangerous),
              IconButtonWidget(
                  screen: 'Show',
                  settingShow: setShowScreen,
                  usingState: 0,
                  settingHome: widget.settingHome,
                  iconAction: 'updateItem',
                  model: widget.model,
                  selectedIcon: Icons.edit),
              IconButtonWidget(
                  screen: 'Show',
                  settingShow: setShowScreen,
                  settingHome: widget.settingHome,
                  usingState: 0,
                  iconAction: 'deleteItem',
                  model: widget.model,
                  selectedIcon: Icons.delete),
            ],
          )
        ],
      ),
    );
  }
}
