import 'dart:math';

import 'package:flutter/material.dart';

import '../db_service/needed_item_db_service.dart';
import '../model/needed_item_model.dart';
import '../widget/upload_widget/text_box_widget.dart';
import '../widget/upload_widget/show_text_widget.dart';

class UploadNeededItemScreen extends StatefulWidget {
  UploadNeededItemScreen({
    super.key,
    required this.settingHome,
  });

  late Function settingHome;
  @override
  State<UploadNeededItemScreen> createState() => _UploadItemScreenState();
}

class _UploadItemScreenState extends State<UploadNeededItemScreen> {
  final sortList = [
    '공구',
    '필기구',
    '간식',
    '기계',
    '기타'
  ];
  var _selectedSort = '공구'; //디폴트값

  final countList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  var _selectedBundle = '1'; //디폴트값

  final itemnameTextController = TextEditingController();
  final countTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final reasonTextController = TextEditingController();

  late var neededItemNameInput, neededPriceInput, neededCountInput, neededReasonInput, neededSortInput, neededBundleInput, neededIsExpendablesInput;

  @override
  void dispose() {
    itemnameTextController.dispose();
    countTextController.dispose();
    priceTextController.dispose();
    reasonTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    isSelected = [
      isMetric,
      isImperial
    ];
    super.initState();

    //int counter = 0;
  } // 소모품 비품toggle버튼에서 사용

  void saveDatabase() {
    //아래 코드를 컨트롤러로 뺄지 고민
    // 빼려면 데이터들을 모두 넘겨주어야 함.
    NeededItemModel newModel = NeededItemModel(
      id: Random().nextInt(10000) + 1,
      name: neededItemNameInput,
      count: int.parse(neededCountInput),
      bundle: int.parse(neededBundleInput),
      price: int.parse(neededPriceInput),
      sort: neededSortInput,
      reason: neededReasonInput,
      isExpendables: neededIsExpendablesInput == '소모품' ? 1 : 0,
    );

    NeededItemDBService.insertNeededItem(newModel);

    widget.settingHome();
    print('saveDatabase');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 60,
        horizontal: 15,
      ),
      key: GlobalKey<FormState>(),
      child: Hero(
        tag: "popup",
        child: Material(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
//-----------------------뒤로가기 버튼, 필요물품 추가----------------------------
                  Row(
                    //최상단 필요물품 추가하기
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_outlined),
                        color: const Color.fromARGB(255, 55, 61, 79),
                        iconSize: 32,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      ShowTextWidget(
                        textContent: '필요 물품 추가하기',
                        contentFontSize: 26,
                        contentFontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
//-----------------------------물품명(TextFormField)----------------------------
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 600,
                      child: Column(
                        children: [
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
                                myTextController: itemnameTextController,
                              ),
                            ],
                          ),
//----------------------------종류(DropdownButton)-----------------------------
                          const SizedBox(height: 20),
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
//--------------------개수(TextFormField), set(bundle)--------------------------
                          const SizedBox(height: 20),
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
                              //dropownbutton
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
                                  value: _selectedBundle,
                                  items: countList.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _selectedBundle = value!;
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
//--------------------------------총 가격(TextFormField)------------------------
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              ShowTextWidget(
                                textContent: '총 가격',
                                contentFontSize: 20,
                              ),
                              const SizedBox(width: 17),
                              TextBoxWidget(
                                hintText: '예)24.000',
                                warningText: '가격을 입력해주세요',
                                textbox_width: 200,
                                textbox_height: 45,
                                myTextController: priceTextController,
                              ),
                              const SizedBox(width: 10),
                              ShowTextWidget(
                                textContent: '원',
                                contentFontSize: 20,
                              ),
                            ],
                          ),
//------------------------------소모품(toggleButtons)---------------------------
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //소모품 비품 선택하는 위젯
                              ToggleButtons(
                                isSelected: isSelected,
                                onPressed: toggleSelect,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: ShowTextWidget(
                                      textContent: '소모품',
                                      contentFontSize: 15,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: ShowTextWidget(
                                      textContent: '비품',
                                      contentFontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
//----------------------------필요이유(TextFormField)---------------------------
                          const SizedBox(height: 10),

                          TextFormField(
                            controller: reasonTextController,
                            maxLines: 8,
                            maxLength: 100,
                            decoration: const InputDecoration(border: OutlineInputBorder(), labelText: '필요이유', hintText: '필요이유를 작성해주세요'),
                          ),
//-----------------------------아이콘 버튼(변수 저장)----------------------------
                          IconButton(
                            color: const Color.fromARGB(255, 55, 61, 79),
                            iconSize: 50,
                            icon: const Icon(Icons.add_circle),
                            onPressed: () {
                              neededItemNameInput = itemnameTextController.text;
                              neededPriceInput = priceTextController.text;
                              neededCountInput = countTextController.text;
                              neededReasonInput = reasonTextController.text;
                              neededSortInput = _selectedSort;
                              neededBundleInput = _selectedBundle;
                              neededIsExpendablesInput = isExpendable;
                              print(priceTextController.text);
                              Navigator.pop(context);
                              saveDatabase();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
      isSelected = [
        isMetric,
        isImperial
      ];
    });
  }
}
