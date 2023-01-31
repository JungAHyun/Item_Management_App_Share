import 'dart:math';

import 'package:item_management_ver2/db_service/needed_item_db_service.dart';

import '../model/needed_item_model.dart';

/// 샘플 데이터 클래스
class MakeNeededItemSample {
  List<NeededItemModel> neededmodelList = [];
  List<String> nameList = [];

  ///DB에 있는 아이템 이름만 List로 반환
  List<String> getNeededNameList() {
    for (var i = 0; i < neededmodelList.length; i++) {
      String name = neededmodelList[i].name;
      nameList.add(name);
    }
    return nameList;
  }

  ///DB 샘플 만들어서 insert하고, DB에서 데이터 불러와서 Model List 반환
  Future<List<NeededItemModel>> makeNeededItemList() {
    //모델 생성(controaller?)
    var num = Random().nextInt(10000) + 1;
    neededmodelList.add(NeededItemModel(
        id: Random().nextInt(10000) + 1,
        name: '종이컵',
        count: 20,
        price: 12000,
        bundle: 5,
        sort: '생필품',
        reason: '컵이 없어요ㅜㅜ'));
    neededmodelList.add(NeededItemModel(
        id: Random().nextInt(10000) + 1,
        name: '큰 종이컵',
        count: 10,
        price: 12000,
        bundle: 3,
        sort: '생필품',
        reason: '큰 컵이 없어서 물을 못마시는 중'));
    neededmodelList.add(NeededItemModel(
        id: Random().nextInt(10000) + 1,
        name: '하리보 젤리',
        count: 50,
        price: 23000,
        sort: '간식',
        reason: '젤리젤리젤리냠냠냠'));
    neededmodelList.add(NeededItemModel(
        id: Random().nextInt(10000) + 1,
        name: 'A4용지',
        count: 20,
        price: 50000));
    neededmodelList.add(NeededItemModel(
        id: Random().nextInt(10000) + 1,
        name: '초콜릿',
        count: 10,
        price: 2000,
        bundle: 10,
        sort: '간식'));
    neededmodelList.add(NeededItemModel(
        id: Random().nextInt(10000) + 1,
        name: '물티슈',
        count: 10,
        price: 30000,
        sort: '생필품'));
    neededmodelList.add(NeededItemModel(
        id: Random().nextInt(10000) + 1,
        name: '줄자',
        count: 1,
        price: 5000,
        sort: '공구',
        reason: '줄자 망가짐',
        isExpendables: 0));
    neededmodelList.add(NeededItemModel(
        id: Random().nextInt(10000) + 1,
        name: '망치',
        count: 1,
        price: 2500,
        bundle: 1,
        sort: '공구',
        isExpendables: 0));
    neededmodelList.add(NeededItemModel(
        id: Random().nextInt(10000) + 1,
        name: '보드마카',
        count: 10,
        price: 30000));

    neededmodelList.add(NeededItemModel(
        id: Random().nextInt(10000) + 1,
        name: '몽키스패너',
        count: 1,
        price: 33000,
        sort: '공구',
        reason: '필요함',
        isExpendables: 0));

    for (var i = 0; i < neededmodelList.length; i++) {
      NeededItemDBService.insertNeededItem(neededmodelList[i]);
    }
    return NeededItemDBService.getNeededItemList();
  }
}
