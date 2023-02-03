import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/existed_item_model.dart';

class ExistedItemDBQuery {
  static late Database _database;

  static Future<Database?> get database async {
    _database = await initDB();
    return _database;
  }

  static initDB() async {
    String path = join(await getDatabasesPath(), 'ExistedItems.db');

    // Delete the database
    // await deleteDatabase(path);

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute("CREATE TABLE ExistedItems(id INTEGER PRIMARY KEY , name TEXT , count INTEGER, bundle INTEGER ,price INTEGER, isNeeded INTEGER , isExpendables INTEGER , broadLocation TEXT,  narrowLocation TEXT,  detailLocation TEXT, note TEXT,sort TEXT, isUsing INTEGER)");
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }

  static void insertExistedItemDB(ExistedItemModel existItem) async {
    final db = await database;

    await db!.insert(
      'ExistedItems',
      existItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  ///DB에서 모든 데이터를 불러와서 하나씩 모델 생성하고, 모두 List로 반환
  static Future<List<ExistedItemModel>> getExistedItemListDB() async {
    final db = await database;

    // 모든 데이터를 얻기 위해 테이블에 질의, db에서 데이터 얻어옴.
    final List<Map<String, dynamic>> maps = await db!.query('ExistedItems');

    // List<Map<String, dynamic>를 List<NeededItemModel>으로 변환
    return List.generate(maps.length, (index) {
      return ExistedItemModel(
        id: maps[index]["id"],
        name: maps[index]["name"],
        count: maps[index]["count"],
        bundle: maps[index]["bundle"],
        isNeeded: maps[index]["isNeeded"],
        isExpendables: maps[index]["isExpendables"],
        broadLocation: maps[index]["broadLocation"],
        narrowLocation: maps[index]["narrowLocation"],
        detailLocation: maps[index]["detailLocation"],
        note: maps[index]["note"],
        sort: maps[index]["sort"],
        isUsing: maps[index]["isUsing"],
      );
    });
  }

  ///id가 같은 데이터 하나만 불어오기(해당 정보 띄울때 사용)
  static Future<List<ExistedItemModel>> getExistedItemDB(ExistedItemModel existedItem) async {
    final db = await database;

    // 모든 데이터를 얻기 위해 테이블에 질의, db에서 데이터 얻어옴.
    final List<Map<String, dynamic>> maps = await db!.query(
      'ExistedItems',
      where: 'id = ?',
      whereArgs: [
        existedItem.id
      ],
    );

    // List<Map<String, dynamic>를 List<NeededItemModel>으로 변환
    return List.generate(maps.length, (index) {
      return ExistedItemModel(
        id: maps[index]["id"],
        name: maps[index]["name"],
        count: maps[index]["count"],
        bundle: maps[index]["bundle"],
        isNeeded: maps[index]["isNeeded"],
        isExpendables: maps[index]["isExpendables"],
        broadLocation: maps[index]["broadLocation"],
        narrowLocation: maps[index]["narrowLocation"],
        detailLocation: maps[index]["detailLocation"],
        note: maps[index]["note"],
        sort: maps[index]["sort"],
      );
    });
  }

  static Future<void> deleteExistedItemDB(ExistedItemModel existedItem) async {
    final db = await database;

    await db!.delete(
      'ExistedItems',
      // 특정 dog를 제거하기 위해 `where` 절을 사용
      where: "id = ?",
      whereArgs: [
        existedItem.id
      ],
    );
  }

  static Future<void> updateExistedItemDB(ExistedItemModel existedItem) async {
    final db = await database;

    await db!.update(
      'ExistedItems',
      existedItem.toMap(),
      where: "id = ?",
      whereArgs: [
        existedItem.id
      ],
    );
  }
}
