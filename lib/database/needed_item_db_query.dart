import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/needed_item_model.dart';

class NeededItemDBQuery {
  static late Database _database;

  static Future<Database?> get database async {
    _database = await initDB();
    return _database;
  }

  static initDB() async {
    String path = join(await getDatabasesPath(), 'NeededItems.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE NeededItems(id INTEGER PRIMARY KEY , name TEXT , count INTEGER, bundle INTEGER ,price INTEGER, isNeeded INTEGER , isExpendables INTEGER , reason TEXT,sort TEXT)");
      },
      onUpgrade: (db, oldVersion, newVersion) {},
    );
  }

  static Future<void> insertNeededItemDB(NeededItemModel neededItem) async {
    final db = await database;

    await db!.insert(
      'NeededItems',
      neededItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  ///DB에서 모든 데이터를 불러와서 하나씩 모델 생성하고, 모두 List로 반환
  static Future<List<NeededItemModel>> getNeededItemListDB() async {
    final db = await database;

    // 모든 데이터를 얻기 위해 테이블에 질의, db에서 데이터 얻어옴.
    final List<Map<String, dynamic>> maps = await db!.query('NeededItems');

    // List<Map<String, dynamic>를 List<NeededItemModel>으로 변환
    return List.generate(maps.length, (index) {
      return NeededItemModel(
        id: maps[index]["id"],
        name: maps[index]["name"],
        count: maps[index]["count"],
        bundle: maps[index]["bundle"],
        price: maps[index]["price"],
        isNeeded: maps[index]["isNeeded"],
        isExpendables: maps[index]["isExpendables"],
        reason: maps[index]["reason"],
        sort: maps[index]["sort"],
      );
    });
  }

  ///id가 같은 데이터 하나만 불어오기(해당 정보 띄울때 사용)
  static Future<List<NeededItemModel>> getNeededItemDB(NeededItemModel neededItem) async {
    final db = await database;

    // 모든 데이터를 얻기 위해 테이블에 질의, db에서 데이터 얻어옴.
    final List<Map<String, dynamic>> maps = await db!.query(
      'NeededItems',
      where: 'id = ?',
      whereArgs: [
        neededItem.id
      ],
    );

// List<Map<String, dynamic>를 List<NeededItemModel>으로 변환
    return List.generate(maps.length, (index) {
      return NeededItemModel(
        id: maps[index]["id"],
        name: maps[index]["name"],
        count: maps[index]["count"],
        bundle: maps[index]["bundle"],
        price: maps[index]["price"],
        isNeeded: maps[index]["isNeeded"],
        isExpendables: maps[index]["isExpendables"],
        reason: maps[index]["reason"],
        sort: maps[index]["sort"],
      );
    });
  }

  static Future<void> deleteNeededItemDB(NeededItemModel neededItem) async {
    final db = await database;

    await db!.delete(
      'NeededItems',
      where: "id = ?",
      whereArgs: [
        neededItem.id
      ],
    );
  }

  static Future<void> updateNeededItemDB(NeededItemModel neededItem) async {
    final db = await database;

    await db!.update(
      'NeededItems',
      neededItem.toMap(),
      where: "id = ?",
      whereArgs: [
        neededItem.id
      ],
    );
  }
}
