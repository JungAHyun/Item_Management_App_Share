// import '../model/existed_item_model.dart';
// import '../model/needed_item_model.dart';

import 'package:item_management_ver2/model/needed_item_model.dart';

import '../database/existed_item_db_query.dart';
import '../model/existed_item_model.dart';
import 'needed_item_db_service.dart';

class ExistedItemDBService {
  ///ExistedItemDBQuery이용해서 db에 넣음
  static void insertExistedItem(ExistedItemModel itemModel) {
    ExistedItemDBQuery.insertExistedItemDB(itemModel);
  }

  ///ExistedItemDBQuery이용해서 db 수정
  static void updateExistedItem(ExistedItemModel itemModel) {
    ExistedItemDBQuery.updateExistedItemDB(itemModel);
  }

  ///ExistedItemDBQuery이용해서 db 삭제
  static void deleteExistedItem(ExistedItemModel itemModel) {
    ExistedItemDBQuery.deleteExistedItemDB(itemModel);
  }

  ///ExistedItemDBQuery이용해서 db에서 가져옴
  static Future<List<ExistedItemModel>> getExistedItemList() {
    return ExistedItemDBQuery.getExistedItemListDB();
  }

  ///ExistedItemDBQuery이용해서 id에 해당하는 데이터를 db에서 가져옴
  static Future<List<ExistedItemModel>> getExistedItem(
      ExistedItemModel itemModel) {
    return ExistedItemDBQuery.getExistedItemDB(itemModel);
  }

  ////DB의 count수 하나씩 줄이는 함수
  static void clickMinusButton(ExistedItemModel itemModel) {
    //개수가 남은경우
    itemModel.count = itemModel.count - 1;
    ExistedItemDBQuery.updateExistedItemDB(itemModel);
    if (itemModel.count != 1 && itemModel.bundle != 1) {
      itemModel.count = itemModel.count - 1;
      ExistedItemDBQuery.updateExistedItemDB(itemModel);
    }
    //개수가 안 남고 세트가 남은 경우
    else if (itemModel.count <= 1 && itemModel.bundle != 0) {
      itemModel.count = itemModel.countPerSet;
      itemModel.bundle = itemModel.bundle - 1;
      ExistedItemDBQuery.updateExistedItemDB(itemModel);
    }
    //둘다 없는 경우 필요 물품으로 넘어감
    else if (itemModel.count <= 1 && itemModel.bundle <= 0) {
      noExistedItem(itemModel);
    }
  }

  ///DB의 사용중(isusing) 상태를 변환시키는 함수
  static void clickUsingButton(ExistedItemModel itemModel) {
    itemModel.isUsing == 0 ? itemModel.isUsing = 1 : itemModel.isUsing = 0;
    ExistedItemDBQuery.updateExistedItemDB(itemModel);
  }

  ///개수가 0이 되면 필요물품으로 넘어가게 하는 함수
  static noExistedItem(ExistedItemModel itemModel) {
    NeededItemModel newModel = NeededItemModel(
      id: itemModel.id,
      name: itemModel.name,
      price: 00,
      count: itemModel.countPerSet,
      sort: itemModel.sort,
      isExpendables: itemModel.isExpendables,
      isNeeded: 1,
      reason: '구비되어있던 물품을 모두 소진하였습니다.',
    );
    NeededItemDBService.insertNeededItem(newModel);
    ExistedItemDBService.deleteExistedItem(itemModel);
  }
}
