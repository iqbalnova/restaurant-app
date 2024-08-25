import 'package:myresto/data/models/restaurant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'wishlist.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE wishlist (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            city TEXT,
            pictureId TEXT,
            rating REAL
          )
        ''');
      },
    );
  }

  Future<void> addRestaurant(Restaurant restaurant) async {
    final db = await database;
    await db.insert(
      'wishlist',
      restaurant.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeRestaurant(String id) async {
    final db = await database;
    await db.delete(
      'wishlist',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Restaurant>> getWishlist() async {
    final db = await database;
    final maps = await db.query('wishlist');

    return List.generate(maps.length, (i) {
      return Restaurant.fromJson(maps[i]);
    });
  }
}
