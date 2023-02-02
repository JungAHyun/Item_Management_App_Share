import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../model/needed_item_model.dart';

import 'needed_item_widget.dart';

class NeededItemListWidget extends StatelessWidget {
  final Future<List<NeededItemModel>> neededItemList;
  late Function settingHome;

  NeededItemListWidget({
    Key? key,
    required this.neededItemList,
    required this.settingHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: neededItemList,
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
                  model: item,
                  settingHome: settingHome,
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
