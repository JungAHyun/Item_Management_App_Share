import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../model/existed_item_model.dart';
import 'existed_item_widget.dart';

class ExistedItemListWidget extends StatelessWidget {
  final Future<List<ExistedItemModel>> existedItemList;
  late Function settingHome;

  ExistedItemListWidget({
    Key? key,
    required this.existedItemList,
    required this.settingHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: existedItemList,
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
                print(index);
                var item = snapshot.data![index];
                //컨테이너 리턴하기
                return ExistedItemWidget(
                  settingHome: settingHome,
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
