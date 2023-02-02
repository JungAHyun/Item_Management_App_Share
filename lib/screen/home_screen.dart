import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../database/existed_item_sample.dart';
import '../database/needed_item_sample.dart';

import '../db_service/existed_item_db_service.dart';
import '../db_service/needed_item_db_service.dart';
import '../model/existed_item_model.dart';
import '../model/needed_item_model.dart';
import 'upload_existed_item_screen.dart';
import 'upload_needed_item_screen.dart';
import '../widget/home_widget/existed_list_widget.dart';
import '../widget/home_widget/needed_list_widget.dart';
//popupcard
import 'package:popup_card/src/hero_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  ///샘플 객체 생성
  static MakeNeededItemSample neededItemsSample = MakeNeededItemSample();
  static MakeExistedItemSample existedItemsSample = MakeExistedItemSample();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  // DB setting : 처음에 DB가 없을 때 주석지우고 실행해야함.
  ///샘플을  DB에 넣고,  있는 모든 Model 데이터 List 가져옴.
  // Future<List<NeededItemModel>> neededItemModelList = HomeScreen.neededItemsSample.makeNeededItemList();
  // Future<List<ExistedItemModel>> existedItemModelList = HomeScreen.existedItemsSample.makeExistedItemList();

  //처음 위 코드로 DB와 샘플데이터를 만들어 한번 실행후에는
  //위 코드 주석하고 아래 두 코드를 계속 사용
  Future<List<NeededItemModel>> neededItemModelList = NeededItemDBService.getNeededItemList();
  Future<List<ExistedItemModel>> existedItemModelList = ExistedItemDBService.getExistedItemList();

  /// 구비물품 목록누르면 false로 변환
  bool isNeeded = true;

  /// 목록 container 누르면 isNeeded를 바꾸는 함수
  /// => isNeeded에 따라 스크린에 뜨는 위젯이 달라짐.
  void changeListSort(bool clickedListSort) {
    setState(() {
      if (isNeeded != clickedListSort) {
        isNeeded = !isNeeded;
      }
    });
  }

  ///데이터 변경될 때 마다 HomeScreen 다시 세팅 해주는 함수
  void setHomeScreen() {
    setState(() {
      print('setHomeState');
      neededItemModelList = NeededItemDBService.getNeededItemList();
      existedItemModelList = ExistedItemDBService.getExistedItemList();
      makeItemListWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 55, 61, 79),
        centerTitle: true,
        title: const Text(
          'Item Manager',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
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
                height: 5,
              ),
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
                      children: <Widget>[
                        const Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownSearch<String>(
                                //isNeeded가 true(1)이면 필요 물품 이름을 보여주고,
                                // false(0)이면 구비 물품 이름을 보여줌.
                                items: isNeeded ? HomeScreen.neededItemsSample.getNeededNameList() : HomeScreen.existedItemsSample.getExistedNameList(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //쓰려고했던 검색바
                  //     GFSearchBar(
                  //   searchList: isNeeded
                  //       ? HomeScreen.neededItemsSample.getNeededNameList()
                  //       : HomeScreen.existItemsSample.getExistedNameList(),
                  //   searchQueryBuilder: (query, list) {
                  //     return list
                  //         .where((item) =>
                  //             item.toLowerCase().contains(query.toLowerCase()))
                  //         .toList();
                  //   },
                  //   overlaySearchListItemBuilder: (item) {
                  //     return Container(
                  //       padding: const EdgeInsets.all(8),
                  //       child: Text(
                  //         item,
                  //         style: const TextStyle(fontSize: 18),
                  //       ),
                  //     );
                  //   },
                  //   onItemSelected: (item) {
                  //     setState(() {
                  //       print(item);
                  //     });
                  //   },
                  // ),
                ),
              ),
              //-----------------------------물품 목록 종류 UI 및 액션 부분---------------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                              //isNeeded에 따라 구분선 색 변화.
                              color: isNeeded ? const Color.fromARGB(255, 55, 61, 79) : const Color.fromARGB(255, 160, 162, 167),
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
                              color: isNeeded ? const Color.fromARGB(255, 160, 162, 167) : const Color.fromARGB(255, 55, 61, 79),
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
              //-----------------------------item위젯 보여주는 부분--------------------------------------
              //isNeeded에 따라 item list 생성하는 위젯에 model list데이터 넘겨줌
              makeItemListWidget()
            ],
          ),

          //-----------------------------아래에 Plus 버튼 UI부분--------------------------------------
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                HeroDialogRoute(
                  builder: ((context) => isNeeded ? UploadNeededItemScreen(settingHome: setHomeScreen) : UploadExistedItemScreen(settingHome: setHomeScreen)),
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
    );
  }

  ///필요물품과 구비물품을 생성하고 UI를 화면에 띄우는 함수
  StatelessWidget makeItemListWidget() {
    return isNeeded ? NeededItemListWidget(neededItemList: neededItemModelList, settingHome: setHomeScreen) : ExistedItemListWidget(existedItemList: existedItemModelList, settingHome: setHomeScreen);
  }
}
