import 'package:flutter/material.dart';

import '../../model/existed_item_model.dart';
import '../../screen/show_existed_data_screen.dart';
import '../show_widget/icon_button_widget.dart';

class ExistedItemWidget extends StatelessWidget {
  late ExistedItemModel model;
  late String name = model.name;
  late int count = model.count;
  late int bundle = model.bundle;
  late String broadLocation = model.broadLocation;
  late String narrowLocation = model.narrowLocation;
  late String detailLocation = model.detailLocation;
  late Function settingHome;

  ExistedItemWidget({
    super.key,
    required this.model,
    required this.settingHome,
  });

  @override
  Widget build(BuildContext context) {
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
        height: 100, //고쳐도 적용안됨.
        width: 360,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 120,
                  child: Text(
                    name,
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
              SizedBox(
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$count개 ${bundle}Set',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 55, 61, 79),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '$broadLocation $narrowLocation $detailLocation',
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
