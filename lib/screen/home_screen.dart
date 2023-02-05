import 'package:flutter/material.dart';
import 'package:item_management_ver2/widget/home_widget/existed_list_widget.dart';
import '../db_service/existed_item_db_service.dart';
import '../db_service/needed_item_db_service.dart';
import '../model/existed_item_model.dart';
import '../model/needed_item_model.dart';
import 'upload_existed_item_screen.dart';
import 'upload_needed_item_screen.dart';
import '../widget/home_widget/needed_list_widget.dart';
//popupcard
import 'package:popup_card/src/hero_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isNeeded = true;
  final TextEditingController textController = TextEditingController();
  // final FocusNode focusNode = FocusNode();

  ///DB에서 아이템리스트 get해오는 함수
  Future<List<NeededItemModel>> getNeededItemModelList() =>
      NeededItemDBService.getNeededItemList();
  Future<List<ExistedItemModel>> getExitedItemModelList() =>
      ExistedItemDBService.getExistedItemList();

  ///데이터 변경될 때 마다 HomeScreen 다시 세팅 해주는 함수
  void setHomeScreen() {
    setState(() {
      getNeededItemModelList();
      getExitedItemModelList();
    });
  }

  ///물품 목록을 누를 때마다 isNeeded 변수를 변경하는 함수
  void changeListSort(bool clickedListSort) {
    setState(() {
      if (isNeeded != clickedListSort) {
        isNeeded = !isNeeded;
      }
    });
  }

  void searchItem(String item) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //============================App Bar=====================================
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 55, 61, 79),
          centerTitle: true,
          //============================title=====================================
          title: const Text(
            'Item Manager',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          //=============================icon=====================================
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.assignment_late_outlined),
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                //==========================검색바================================
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.grey,
                    ),
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: 360,
                  height: 50,
                  child: Center(
                    child: TextField(
                      controller: textController,
                      // focusNode: focusNode,
                      textInputAction: TextInputAction.go,
                      onSubmitted: (value) => searchItem(textController.text),
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () => searchItem(textController.text),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {},
                        ),
                        hintText: '물품을 검색하세요',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //=====================물품 목록 선택=============================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            changeListSort(true);
                          },
                          child: Center(
                            child: Column(
                              children: [
                                const Text(
                                  '필요 물품 목록',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Divider(
                                    color: isNeeded
                                        ? const Color.fromARGB(255, 55, 61, 79)
                                        : const Color.fromARGB(
                                            255, 160, 162, 167),
                                    thickness: 2.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            changeListSort(false);
                          },
                          child: Center(
                            child: Column(
                              children: [
                                const Text(
                                  '구비 물품 목록',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Divider(
                                    color: isNeeded
                                        ? const Color.fromARGB(
                                            255, 160, 162, 167)
                                        : const Color.fromARGB(255, 55, 61, 79),
                                    thickness: 2.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                //=======================Item ListView============================
                isNeeded
                    ? NeededItemListWidget(
                        modelList: getNeededItemModelList(),
                        settingHome: setHomeScreen,
                      )
                    : ExistedItemListWidget(
                        modelList: getExitedItemModelList(),
                        settingHome: setHomeScreen,
                      )
              ],
            ),

            //===========================Plus Icon================================
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  HeroDialogRoute(
                    builder: ((context) => isNeeded
                        ? UploadNeededItemScreen(
                            settingHome: setHomeScreen,
                          )
                        : UploadExistedItemScreen(
                            settingHome: setHomeScreen,
                          )),
                  ),
                );
              },
              child: const Align(
                alignment: Alignment(0.88, 0.9),
                child: Hero(
                  tag: 'popup',
                  child: Icon(
                    Icons.add_circle,
                    color: Color.fromARGB(255, 55, 61, 79),
                    size: 60,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
