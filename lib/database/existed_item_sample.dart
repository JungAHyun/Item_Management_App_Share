import 'dart:math';

import 'package:item_management_ver2/db_service/existed_item_db_service.dart';

import '../model/existed_item_model.dart';

/// 샘플 데이터 클래스
class MakeExistedItemSample {
  List<ExistedItemModel> existedmodelList = [];
  List<String> nameList = [];

  ///DB에 있는 아이템 이름만 List로 반환
  List<String> getExistedNameList() {
    for (var i = 0; i < existedmodelList.length; i++) {
      String name = existedmodelList[i].name;
      nameList.add(name);
    }
    return nameList;
  }

  ///DB 샘플 만들어서 insert하고, DB에서 데이터 불러와서 Model List 반환
  Future<List<ExistedItemModel>> makeExistedItemList() {
    //모델 생성(controaller)
    var num = Random().nextInt(10000) + 1;
    existedmodelList.add(
      ExistedItemModel(
        id: Random().nextInt(10000) + 1,
        name: '카누',
        count: 100,
        broadLocation: '의료과학관',
        narrowLocation: '1521호',
        detailLocation: '간식서랍장',
        isNeeded: 0,
      ),
    );
    existedmodelList.add(
      ExistedItemModel(
        id: Random().nextInt(10000) + 1,
        name: '잉크',
        count: 100,
        broadLocation: '의료과학관',
        narrowLocation: '1521호',
        isNeeded: 0,
      ),
    );
    existedmodelList.add(
      ExistedItemModel(
        id: Random().nextInt(10000) + 1,
        name: '치약',
        count: 1,
        broadLocation: '의료과학관',
        narrowLocation: '1521호',
        detailLocation: '세면대',
        sort: '생필품',
        isNeeded: 0,
      ),
    );
    existedmodelList.add(
      ExistedItemModel(
        id: Random().nextInt(10000) + 1,
        name: '가위',
        count: 3,
        broadLocation: '의료과학관',
        narrowLocation: '1521호',
        isNeeded: 0,
      ),
    );
    existedmodelList.add(
      ExistedItemModel(
        id: Random().nextInt(10000) + 1,
        name: '빨대',
        count: 100,
        bundle: 2,
        broadLocation: '의료과학관',
        narrowLocation: '1521호',
        detailLocation: '간식서랍장',
        isNeeded: 0,
      ),
    );
    existedmodelList.add(
      ExistedItemModel(
        id: Random().nextInt(10000) + 1,
        name: 'sd카드',
        count: 20,
        bundle: 5,
        broadLocation: '의료과학관',
        narrowLocation: '1605호',
        sort: '공구',
        isNeeded: 0,
      ),
    );
    existedmodelList.add(
      ExistedItemModel(
        id: Random().nextInt(10000) + 1,
        name: '십자못',
        count: 5,
        bundle: 10,
        broadLocation: '의료과학관',
        narrowLocation: '1521호',
        sort: '공구',
        isNeeded: 0,
      ),
    );
    existedmodelList.add(
      ExistedItemModel(
        id: Random().nextInt(10000) + 1,
        name: '십자드라이버',
        count: 2,
        isNeeded: 0,
        isExpendables: 0,
      ),
    );
    existedmodelList.add(
      ExistedItemModel(
        id: Random().nextInt(10000) + 1,
        name: '큰 부품',
        count: 5,
        sort: '공구',
        isNeeded: 0,
        isExpendables: 0,
      ),
    );
    existedmodelList.add(
      ExistedItemModel(
        id: Random().nextInt(10000) + 1,
        name: '노트북',
        count: 1,
        broadLocation: '아이디자인관',
        sort: '센서',
        isNeeded: 0,
        isExpendables: 0,
      ),
    );
    existedmodelList.add(
      ExistedItemModel(
        id: Random().nextInt(10000) + 1,
        name: '족저압 센서',
        count: 10,
        bundle: 3,
        broadLocation: '아이디자인관',
        sort: '센서',
        isNeeded: 0,
      ),
    );
    existedmodelList.add(
      ExistedItemModel(
        id: Random().nextInt(10000) + 1,
        name: '가속도 센서',
        count: 5,
        broadLocation: '아이디자인관',
        sort: '센서',
        isNeeded: 0,
        isExpendables: 0,
      ),
    );

    for (var i = 0; i < existedmodelList.length; i++) {
      ExistedItemDBService.insertExistedItem(existedmodelList[i]);
    }

    return ExistedItemDBService.getExistedItemList();
  }
}
