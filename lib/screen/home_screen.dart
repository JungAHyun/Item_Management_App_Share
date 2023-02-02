import 'package:flutter/material.dart';
import 'package:item_management_ver2/widget/home_widget/existed_list_widget.dart';

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
  final _formKey = GlobalKey<FormState>();

  // Future<List<NeededItemModel>> neededItemModelList =
  //     NeededItemDBService.getNeededItemList();
  // Future<List<ExistedItemModel>> existedItemModelList =
  //     ExistedItemDBService.getExistedItemList();

  bool isNeeded = true;

  ///isNeeded에 따라 달라지는 ItemList를 새로고침 해주는 기능
  void setHomeScreen(bool clickedListSort) {
    setState(() {
      if (isNeeded != clickedListSort) {
        isNeeded = !isNeeded;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //============================AppBar======================================
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 55, 61, 79),
        centerTitle: true,
        //=========================Title=======================
        title: const Text(
          'Item Manager',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: <Widget>[
          //======================기각 Icon=====================
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
                height: 5,
              ),
              //==========================검색바================================
              SizedBox(
                width: 360,
                height: 95,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child:
                      //SearchBar 생성(지금은 SelectBar여서 수정해야 함)
                      Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: ListView(
                      padding: const EdgeInsets.all(4),
                      children: const <Widget>[
                        Divider(),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: DropdownSearch<String>(
                        //         //isNeeded가 true(1)이면 필요 물품 이름을 보여주고,
                        //         // false(0)이면 구비 물품 이름을 보여줌.
                        //         items: isNeeded
                        //             ? HomeScreen.neededItemsSample
                        //                 .getNeededNameList()
                        //             : HomeScreen.existedItemsSample
                        //                 .getExistedNameList(),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              //====================목록 선택 컨테이너==========================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setHomeScreen(true);
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
                                  //isNeeded에 따라 구분선 색 변화.
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
                          setHomeScreen(false);
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
                                      ? const Color.fromARGB(255, 160, 162, 167)
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
                      settingHome: setHomeScreen,
                      isNeeded: isNeeded,
                    )
                  : ExistedItemListWidget(
                      settingHome: setHomeScreen,
                      isNeeded: isNeeded,
                    )
            ],
          ),

          //===========================Plus Button==============================
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                HeroDialogRoute(
                    builder: ((context) => isNeeded
                        ? UploadNeededItemScreen(settingHome: setHomeScreen)
                        : UploadExistedItemScreen(settingHome: setHomeScreen))),
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
    );
  }
}
