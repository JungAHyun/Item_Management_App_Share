import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../model/needed_item_model.dart';

import 'needed_item_widget.dart';

class NeededItemListWidget extends StatefulWidget {
  final bool isNeeded;
  final Future<List<NeededItemModel>> model;
  late Function settingHome;

  NeededItemListWidget({
    Key? key,
    required this.settingHome,
    required this.isNeeded,
    required this.model,
  }) : super(key: key);

  @override
  State<NeededItemListWidget> createState() => _NeededItemListWidgetState();
}

class _NeededItemListWidgetState extends State<NeededItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //===========future에 List<NeededItemModel>을 저장========================
      future: widget.model,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: 550,
            width: 390,
            //=====future인 List<NeededItemModel>을 ListView 형태로 보여줌======
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 17),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
              //=========List 요소인 NeededItemModel을 각 위젯에 넘겨줌=========
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                return NeededItemWidget(
                  model: item,
                  settingHome: widget.settingHome,
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
        // SizedBox(
        //   height: 150,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       const Center(
        //         child: Text(
        //           'laoding',
        //           style: TextStyle(fontSize: 3),
        //         ),
        //       ),
        //       Center(
        //         child: LoadingAnimationWidget.waveDots(
        //           color: const Color.fromARGB(255, 55, 61, 79),
        //           size: 15,
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      },
    );
  }
}
