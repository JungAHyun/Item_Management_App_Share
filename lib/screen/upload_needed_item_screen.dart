import 'dart:math';

import 'package:flutter/material.dart';

import '../db_service/needed_item_db_service.dart';
import '../model/needed_item_model.dart';
import '../widget/upload_widget/text_box_widget.dart';
import '../widget/upload_widget/title_type_widget.dart';

class UploadItemScreen extends StatefulWidget {
  UploadItemScreen({
    super.key,
    required this.settingHome,
  });

  late Function settingHome;
  @override
  State<UploadItemScreen> createState() => _UploadItemScreenState();
}

class _UploadItemScreenState extends State<UploadItemScreen> {
  final sortlist = ['공구', '필기구', '간식', '기계', '기타'];
  var _selectedsort = '공구'; //디폴트값

  final countlist = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  var _selectedbunddle = '1'; //디폴트값

  final itemnameTextController = TextEditingController();
  final countTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final contentTextController = TextEditingController();

  late var neededItemNameInput,
      neededPriceInput,
      neededCountInput,
      neededContentInput;
  late var neededSortInput, neededBunddleInput, neededConsumableInput;

  @override
  void dispose() {
    itemnameTextController.dispose();
    countTextController.dispose();
    priceTextController.dispose();
    contentTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    isSelected = [isMetric, isImperial];
    super.initState();

    int counter = 0;
  }

  void saveDatabase() {
    //아래 코드를 컨트롤러로 뺄지 고민
    // 빼려면 데이터들을 모두 넘겨주어야 함.
    NeededItemModel newModel = NeededItemModel(
      id: Random().nextInt(10000) + 1,
      name: neededItemNameInput ?? '물품명을 작성해주세요',
      count: int.parse(neededCountInput),
      bundle: int.parse(neededBunddleInput),
      price: int.parse(neededPriceInput),
      sort: neededSortInput ?? '기타',
      reason: neededContentInput ?? '필요함',
      isExpendables: neededConsumableInput == '소모품' ? 1 : 0,
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
      child: Hero(
        tag: "popup",
        child: Material(
          color: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
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
                      const Text(
                        '필요 물품 추가하기',
                        style: TextStyle(
                          color: Color.fromARGB(255, 55, 61, 79),
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  //물품명 적는 위젯
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 600,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const TitletypeWidget(title: '물품명'),
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

                          const SizedBox(height: 20),
                          //종류 선택하는 위젯
                          Row(
                            children: [
                              const TitletypeWidget(title: '종류'),
                              const SizedBox(width: 40),
                              Container(
                                height: 45,
                                width: 75,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 55, 61, 79),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButton(
                                  alignment: Alignment.center,
                                  value: _selectedsort,
                                  items: sortlist.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _selectedsort = value!;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          //개수 선택하는 위젯
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const TitletypeWidget(title: '개수'),
                              const SizedBox(width: 40),
                              TextBoxWidget(
                                hintText: ' 5 ',
                                warningText: '개수를 입력해주세요',
                                textbox_width: 70,
                                textbox_height: 45,
                                myTextController: countTextController,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                '개',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 55, 61, 79),
                                  fontSize: 15,
                                  //fontFamily: 'Explora-Regular',
                                ),
                              ),
                              const SizedBox(width: 25),
                              Container(
                                height: 45,
                                width: 55,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 55, 61, 79),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButton(
                                  alignment: Alignment.center,
                                  value: _selectedbunddle,
                                  items: countlist.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _selectedbunddle = value!;
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'set',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 55, 61, 79),
                                  fontSize: 15,
                                  //fontFamily: 'Explora-Regular',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              //가격 입력하는 위젯
                              const TitletypeWidget(title: '총 가격'),
                              const SizedBox(width: 17),
                              TextBoxWidget(
                                hintText: '예)24.000',
                                warningText: '가격을 입력해주세요',
                                textbox_width: 200,
                                textbox_height: 45,
                                myTextController: priceTextController,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                '원',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 55, 61, 79),
                                  fontSize: 20,
                                  //fontFamily: 'Explora-Regular',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //소모품 비품 선택하는 위젯
                              ToggleButtons(
                                isSelected: isSelected,
                                onPressed: toggleSelect,
                                children: const [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      '소모품',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 55, 61, 79),
                                          backgroundColor: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      ' 비품 ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 55, 61, 79),
                                          backgroundColor: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          //필요이유 입력하는 위젯
                          TextFormField(
                            controller: contentTextController,
                            maxLines: 8,
                            maxLength: 100,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '필요이유',
                                hintText: '필요이유를 작성해주세요'),
                          ),

                          IconButton(
                            color: const Color.fromARGB(255, 55, 61, 79),
                            iconSize: 50,
                            icon: const Icon(Icons.add_circle),
                            onPressed: () {
                              neededItemNameInput = itemnameTextController.text;
                              neededPriceInput = priceTextController.text;
                              neededCountInput = countTextController.text;
                              neededContentInput = contentTextController.text;
                              neededSortInput = _selectedsort;
                              neededBunddleInput = _selectedbunddle;
                              neededConsumableInput = Consumableitem;
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
  var Consumableitem;

  void toggleSelect(value) {
    if (value == 0) {
      isMetric = true;
      isImperial = false;
      Consumableitem = '소모품';
    } else {
      isMetric = false;
      isImperial = true;
      Consumableitem = '비품';
    }
    setState(() {
      isSelected = [isMetric, isImperial];
    });
  }
}
