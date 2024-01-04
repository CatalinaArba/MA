import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../Domain/Saving.dart';

class DatabaseService {
  static const int _version = 2;
  static const String _dbName = 'savings_database10.db';

  static Database? _database;

  //private constructor
  DatabaseService._();

  //singleton instance=> only one instance can be made in the project
  static final DatabaseService dbService = DatabaseService._();

  Future<Database> get database async => _database ??= await _getDB();

  static Future<Database> _getDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return openDatabase(join(directory.path, _dbName),
        onCreate: (db, version) async =>
        await db.execute(
            'CREATE TABLE IF NOT EXISTS Saving(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, category TEXT, '
                'initialDate TEXT, endDate TEXT, totalAmount REAL, monthlyAmount REAL, savedAmount REAL, '
                'created_at TEXT)'), version: _version
    );
  }
  Future<Saving> findByAttributesExceptId(Saving saving) async {
    final db = await _getDB();

    List<Map<String, dynamic>> result = await db.query(
      "Saving",
      where: 'name = ? AND category = ? AND initialDate = ? AND endDate = ? AND totalAmount = ? AND monthlyAmount = ? AND savedAmount = ?',
      whereArgs: [
        saving.name,
        saving.category,
        saving.initialDate,
        saving.endDate,
        saving.totalAmount,
        saving.monthlyAmount,
        saving.savedAmount,
      ],
    );

    if (result.isNotEmpty) {
      return Saving.fromJson(result.first);
    }
    throw Future.error("error");
  }


  Future<int> addSaving(Saving saving) async {
    final db = await _getDB();
    return await db.insert("Saving", saving.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> update(Saving saving) async {
    final db = await _getDB();
    return await db.update("Saving", saving.toJson(), where: 'id=?',
        whereArgs: [saving.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> delete(Saving saving) async {
    final db = await _getDB();
    return await db.delete("Saving", where: 'id=?', whereArgs: [saving.id]);
  }

  Future<List<Saving>> getAllSavings() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Saving");
    if (maps.isEmpty) {
      return [];
    }
    return List.generate(maps.length, (index) => Saving.fromJson(maps[index]));
  }
  Future<void> dropTable() async {
    final db = await _getDB();
    await db.execute("DROP TABLE IF EXISTS Saving");
  }
  Future<void> dropDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File databaseFile = File(join(directory.path, _dbName));
    if (await databaseFile.exists()) {
      await databaseFile.delete();
    }
    _database = null;
  }
}
