// import '../model/existed_item_model.dart';
// import '../model/needed_item_model.dart';

import '../database/needed_item_db_query.dart';

import '../model/existed_item_model.dart';
import '../model/needed_item_model.dart';
import 'existed_item_db_service.dart';

class NeededItemDBService {
  ///NeededItemDBQuery이용해서 db에 넣음
  static void insertNeededItem(NeededItemModel itemModel) {
    NeededItemDBQuery.insertNeededItemDB(itemModel);
  }

  ///NeededItemDBQuery이용해서 db 수정
  static void updateNeededItem(NeededItemModel itemModel) {
    NeededItemDBQuery.updateNeededItemDB(itemModel);
  }

  ///NeededItemDBQuery이용해서 db 삭제
  static void deleteNeededItem(NeededItemModel itemModel) {
    NeededItemDBQuery.deleteNeededItemDB(itemModel);
  }

  ///NeededItemDBQuery이용해서 모든 데이터를 db에서 가져옴
  static Future<List<NeededItemModel>> getNeededItemList() {
    return NeededItemDBQuery.getNeededItemListDB();
  }

  ///NeededItemDBQuery이용해서 id에 해당하는 데이터를 db에서 가져옴
  static Future<List<NeededItemModel>> getNeededItem(
      NeededItemModel itemModel) {
    return NeededItemDBQuery.getNeededItemDB(itemModel);
  }

  static clickBuyButton(NeededItemModel itemModel) {
    ExistedItemModel newModel = ExistedItemModel(
      id: itemModel.id,
      name: itemModel.name,
      count: itemModel.count,
      sort: itemModel.sort,
      isExpendables: itemModel.isExpendables,
      isNeeded: 0,
    );
    ExistedItemDBService.insertExistedItem(newModel);
    NeededItemDBService.deleteNeededItem(itemModel);
  }
}
