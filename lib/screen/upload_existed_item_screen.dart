import 'package:flutter/material.dart';

import '../widget/upload_widget/text_box_widget.dart';
import '../widget/upload_widget/title_type_widget.dart';

class UploadExistedItemScreen extends StatefulWidget {
  const UploadExistedItemScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadExistedItemScreen> createState() =>
      _UploadExistedItemScreenState();
}

class _UploadExistedItemScreenState extends State<UploadExistedItemScreen> {
  final sortlist = ['공구', '필기구', '간식', '기계', '기타'];
  var _selectedsort = '공구'; //디폴트값

  final countlist = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  var _selectedbunddle = '1'; //디폴트값

  final buildinglist = ['의료과학관', '인문과학관', '미디어랩스', '공학관', '본관', '학생회관'];
  var _selectedbuilding = '의료과학관'; //디폴트값

  final locationlist = ['1521호', '1621호', '1506호', '1504호', '1501호', '그 외'];
  var _selectedlocation = '1521호';

  final itemnameTextController = TextEditingController();
  final detailLocationTextController = TextEditingController();
  final countTextController = TextEditingController();
  final contentTextController = TextEditingController();

  //Input받는 데이터가 저장되는 변수들
  var existedItemNameInput,
      existedDetailLocaitonInput,
      existedCountInput,
      existedContentInput;
  var existedSortInput,
      existedbunddleInput,
      existedBuildiongInput,
      existedLocationInput,
      existedConsumableInput;

  @override
  void initState() {
    isSelected = [isMetric, isImperial];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //제일 뒷 배경, 불투명도 처리할 곳
        Hero(
          tag: 'existed_popup',
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
                      //최상단 구비물품 추가하기
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_outlined),
                          color: const Color.fromARGB(255, 55, 61, 79),
                          iconSize: 32,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Text(
                          '구비 물품 추가하기',
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
                              color: const Color.fromARGB(255, 55, 61, 79),
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
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const TitletypeWidget(title: '위치'),
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
                            value: _selectedbuilding,
                            items: buildinglist.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(
                                () {
                                  _selectedbuilding = value!;
                                },
                              );
                            },
                          ),
                        ),
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
                            value: _selectedlocation,
                            items: locationlist.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(
                                () {
                                  _selectedlocation = value!;
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(width: 10),
                      ],
                    ),
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

                    //개수 선택하는 위젯
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
                              color: const Color.fromARGB(255, 55, 61, 79),
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
                    //필요이유 입력하는 위젯
                    TextFormField(
                      controller: contentTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '비고',
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      color: const Color.fromARGB(255, 55, 61, 79),
                      iconSize: 70,
                      onPressed: () {
                        existedItemNameInput = itemnameTextController;
                        existedDetailLocaitonInput =
                            detailLocationTextController;
                        existedCountInput = countTextController;
                        existedContentInput = contentTextController;
                        existedSortInput = _selectedsort;
                        existedbunddleInput = _selectedbunddle;
                        existedBuildiongInput = _selectedbuilding;
                        existedLocationInput = _selectedlocation;
                        existedConsumableInput = Consumableitem;
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
