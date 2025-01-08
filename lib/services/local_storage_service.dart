import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/weather.dart';

class LocalStorageService {
  static const String _dbName = 'weather.db';
  static const int _dbVersion = 1;

  static const String _tableWeather = 'weather';
  static const String _columnData = 'data';

  Database? _database;

  Future<Database> _getDatabase() async {
    if (_database != null) return _database!;

    final path = join(await getDatabasesPath(), _dbName);
    _database = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableWeather (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            $_columnData TEXT NOT NULL
          )
        ''');
      },
    );
    return _database!;
  }

  /// Save Weather Data to Local Database
  Future<void> saveWeather(Weather weather) async {
    final db = await _getDatabase();
    final weatherJson = jsonEncode(weather.toJson()); // Proper JSON encoding
    await db.insert(
      _tableWeather,
      {_columnData: weatherJson},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Load Weather Data from Local Database
  Future<Weather?> loadWeather() async {
    final db = await _getDatabase();
    final result = await db.query(_tableWeather, limit: 1);

    if (result.isNotEmpty) {
      final jsonData = result.first[_columnData] as String;
      final weatherMap = jsonDecode(jsonData); // Proper JSON decoding
      return Weather.fromJson(weatherMap);
    }
    return null;
  }
}