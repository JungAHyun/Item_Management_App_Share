import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../db_service/needed_item_db_service.dart';
import '../../model/needed_item_model.dart';

import 'needed_item_widget.dart';

class NeededItemListWidget extends StatefulWidget {
  final bool isNeeded;
  late Function settingHome;

  NeededItemListWidget({
    Key? key,
    required this.settingHome,
    required this.isNeeded,
  }) : super(key: key);

  @override
  State<NeededItemListWidget> createState() => _NeededItemListWidgetState();
}

class _NeededItemListWidgetState extends State<NeededItemListWidget> {
  /// DB에서 필요물품 목록 읽어오는 함수
  Future<List<NeededItemModel>> getNeededItemModelList() =>
      NeededItemDBService.getNeededItemList();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getNeededItemModelList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: 550,
            width: 390,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 17),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
              itemBuilder: (context, index) {
                // print(index);
                var item = snapshot.data![index];
                //컨테이너 리턴하기
                return NeededItemWidget(
                  settingHome: widget.settingHome,
                  model: item,
                );
              },
            ),
          );
        }
        return Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            LoadingAnimationWidget.prograssiveDots(
              color: const Color.fromARGB(255, 184, 197, 236),
              size: 30,
            ),
          ],
        );
      },
    );
  }
}
