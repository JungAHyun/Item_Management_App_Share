import 'package:flutter/material.dart';
import 'package:item_management_ver2/model/needed_item_model.dart';

import '../../screen/show_needed_data_screen.dart';
import '../show_widget/icon_button_widget.dart';

class NeededItemWidget extends StatelessWidget {
  late NeededItemModel model;
  late String name = model.name;
  late int count = model.count;
  late int bundle = model.bundle;
  late String reason = model.reason;
  late Function settingHome;

  NeededItemWidget({
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
                      reason,
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
