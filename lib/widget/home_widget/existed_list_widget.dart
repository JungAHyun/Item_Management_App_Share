import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../model/existed_item_model.dart';
import 'existed_item_widget.dart';

class ExistedItemListWidget extends StatefulWidget {
  final bool isNeeded;
  final Future<List<ExistedItemModel>> model;
  late Function settingHome;

  ExistedItemListWidget({
    Key? key,
    required this.settingHome,
    required this.isNeeded,
    required this.model,
  }) : super(key: key);

  @override
  State<ExistedItemListWidget> createState() => _ExistedItemListWidgetState();
}

class _ExistedItemListWidgetState extends State<ExistedItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //==========future에 List<ExistedItemModel>을 저장========================
      future: widget.model,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: 550,
            width: 390,
            //=====future인 List<ExistedItemModel>을 ListView 형태로 보여줌=====
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 17),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
              //========List 요소인 ExistedItemModel을 각 위젯에 넘겨줌=========
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                return ExistedItemWidget(
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
