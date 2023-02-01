import 'dart:math';

import 'package:flutter/material.dart';

import '../db_service/existed_item_db_service.dart';
import '../model/existed_item_model.dart';
import '../widget/upload_widget/text_box_widget.dart';
import '../widget/upload_widget/show_text_widget.dart';

class UploadExistedItemScreen extends StatefulWidget {
  UploadExistedItemScreen({
    Key? key,
    required this.settingHome,
  }) : super(key: key);
  late Function settingHome;

  @override
  State<UploadExistedItemScreen> createState() =>
      _UploadExistedItemScreenState();
}

class _UploadExistedItemScreenState extends State<UploadExistedItemScreen> {
  final sortList = ['공구', '필기구', '간식', '기계', '기타'];
  var _selectedSort = '공구'; //디폴트값

  final countList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  var _selectedBunddle = '1'; //디폴트값

  final broadLocationList = ['의료과학관', '인문과학관', '미디어랩스', '공학관', '본관', '학생회관'];
  var _selectedBroadLocation = '의료과학관'; //디폴트값

  final narrowlocationList = [
    '1521호',
    '1621호',
    '1506호',
    '1504호',
    '1501호',
    '그 외'
  ];
  var _selectedNarrowLocation = '1521호';

  //텍스트 필드 변수
  final itemNameTextController = TextEditingController();
  final detailLocationTextController = TextEditingController();
  final countTextController = TextEditingController();
  final noteTextController = TextEditingController();

  //Input받는 데이터가 저장되는 변수들
  var existedItemNameInput,
      existedDetailLocaitonInput,
      existedCountInput,
      existedReasonInput;
  var existedSortInput,
      existedBundleInput,
      existedBroadLocationInput,
      existedNarrowLocationInput,
      existedIsExpendableInput;

  @override
  void dispose() {
    itemNameTextController.dispose();
    countTextController.dispose();
    noteTextController.dispose();
    detailLocationTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    isSelected = [isMetric, isImperial];
    super.initState();
  }

  void saveDatabase() {
    //아래 코드를 컨트롤러로 뺄지 고민
    // 빼려면 데이터들을 모두 넘겨주어야 함.
    ExistedItemModel newModel = ExistedItemModel(
      id: Random().nextInt(10000) + 1,
      name: existedItemNameInput,
      count: int.parse(existedCountInput),
      bundle: int.parse(existedBundleInput),
      broadLocation: existedBroadLocationInput,
      narrowLocation: existedNarrowLocationInput,
      detailLocation: existedDetailLocaitonInput,
      sort: existedSortInput,
      isExpendables: existedIsExpendableInput == '소모품' ? 1 : 0,
    );

    ExistedItemDBService.insertExistedItem(newModel);

    widget.settingHome();
    print('saveDatabase');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //제일 뒷 배경, 불투명도 처리할 곳
        Hero(
          tag: 'popup',
          child: Padding(
            padding: const EdgeInsets.only(top: 70, right: 15, left: 15),
            child: Material(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
//-----------------------뒤로가기 버튼, 구비물품 추가----------------------------
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_outlined),
                          color: const Color.fromARGB(255, 55, 61, 79),
                          iconSize: 32,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 25),
                        ShowTextWidget(
                            textContent: '구비 물품 추가하기',
                            contentFontSize: 26,
                            contentFontWeight: FontWeight.w600),
                      ],
                    ),
                    const SizedBox(height: 30),
                    //물품명 적는 위젯
                    Row(
                      children: [
                        ShowTextWidget(
                          textContent: '물품명',
                          contentFontSize: 20,
                        ),
                        const SizedBox(width: 20),
                        TextBoxWidget(
                          hintText: '예)종이컵',
                          warningText: '물품명을 입력해주세요',
                          textbox_width: 200,
                          textbox_height: 45,
                          myTextController: itemNameTextController,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
//----------------------------종류(DropdownButton)-----------------------------
                    Row(
                      children: [
                        ShowTextWidget(
                          textContent: '종류',
                          contentFontSize: 20,
                        ),
                        const SizedBox(width: 40),
                        Container(
                          height: 45,
                          width: 75,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 55, 61, 79),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButton(
                            alignment: Alignment.center,
                            value: _selectedSort,
                            items: sortList.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(
                                () {
                                  _selectedSort = value!;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
//-------------------------------위치------------------------------------------
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        ShowTextWidget(
                          textContent: '위치',
                          contentFontSize: 20,
                        ),
//----------------------------건물이름(DropdownButton)--------------------------
                        const SizedBox(width: 40),

                        Container(
                          height: 45,
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 55, 61, 79),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButton(
                            alignment: Alignment.center,
                            value: _selectedBroadLocation,
                            items: broadLocationList.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(
                                () {
                                  _selectedBroadLocation = value!;
                                },
                              );
                            },
                          ),
                        ),
//-----------------------------강의실(DropdownButton)---------------------------
                        const SizedBox(width: 20),
                        Container(
                          height: 45,
                          width: 90,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 55, 61, 79),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButton(
                            alignment: Alignment.center,
                            value: _selectedNarrowLocation,
                            items: narrowlocationList.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(
                                () {
                                  _selectedNarrowLocation = value!;
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(width: 10),
                      ],
                    ),
//----------------------------상세위치(TextFormField)---------------------------
                    const SizedBox(height: 20),
                    const SizedBox(width: 40),
                    TextBoxWidget(
                      hintText: '상세위치',
                      warningText: '상세위치을 입력해주세요',
                      textbox_width: 220,
                      textbox_height: 45,
                      myTextController: detailLocationTextController,
                    ),
                    const SizedBox(height: 20),

//--------------------개수(TextFormField), set(bundle)--------------------------
                    Row(
                      children: [
                        ShowTextWidget(
                          textContent: '개수',
                          contentFontSize: 20,
                        ),
                        const SizedBox(width: 40),
                        TextBoxWidget(
                          hintText: ' 5 ',
                          warningText: '개수를 입력해주세요',
                          textbox_width: 70,
                          textbox_height: 45,
                          myTextController: countTextController,
                        ),
                        const SizedBox(width: 10),
                        ShowTextWidget(
                          textContent: '개',
                          contentFontSize: 15,
                        ),
                        const SizedBox(width: 25),
                        Container(
                          height: 45,
                          width: 55,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 55, 61, 79),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButton(
                            alignment: Alignment.center,
                            value: _selectedBunddle,
                            items: countList.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(
                                () {
                                  _selectedBunddle = value!;
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        ShowTextWidget(
                          textContent: 'set',
                          contentFontSize: 15,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
//------------------------------소모품(toggleButtons)---------------------------

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          isSelected: isSelected,
                          onPressed: toggleSelect,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                '소모품',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 55, 61, 79),
                                    backgroundColor: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                ' 비품 ',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 55, 61, 79),
                                    backgroundColor: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
//------------------------------비고(TextFormField)----------------------------
                    TextFormField(
                      controller: noteTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '비고',
                      ),
                    ),
//-----------------------------아이콘 버튼(변수 저장)----------------------------
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      color: const Color.fromARGB(255, 55, 61, 79),
                      iconSize: 70,
                      onPressed: () {
                        existedItemNameInput = itemNameTextController.text;
                        existedDetailLocaitonInput =
                            detailLocationTextController.text;
                        existedCountInput = countTextController.text;
                        existedSortInput = noteTextController.text;
                        existedSortInput = _selectedSort;
                        existedBundleInput = _selectedBunddle;
                        existedBroadLocationInput = _selectedBroadLocation;
                        existedNarrowLocationInput = _selectedNarrowLocation;
                        existedIsExpendableInput = isExpendable;
                        Navigator.pop(context);
                        saveDatabase();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        //컨테이너 밖에 위치하는 아이콘
      ],
    );
  }

//토글버튼에서 사용
  String result = '';
  bool isMetric = true;
  bool isImperial = false;
  late List<bool> isSelected;
  var isExpendable;

  void toggleSelect(value) {
    if (value == 0) {
      isMetric = true;
      isImperial = false;
      isExpendable = '소모품';
    } else {
      isMetric = false;
      isImperial = true;
      isExpendable = '비품';
    }
    setState(() {
      isSelected = [isMetric, isImperial];
    });
  }
}
