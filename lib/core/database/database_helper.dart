import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../features/cart/model/firestore_product.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database?> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'cart_v2.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
     CREATE TABLE local_cart (
        id INTEGER PRIMARY KEY,           
        title TEXT NOT NULL,              
        price REAL NOT NULL,              
        stock REAL NOT NULL,              
        image TEXT,                       
        discountPercentage REAL,          
        quantity INTEGER NOT NULL DEFAULT 1,
        is_synced INTEGER NOT NULL DEFAULT 0 
      )
      ''');
      },
    );
    return _database;
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  Future<List<FirestoreProduct>> getUnSyncedProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'local_cart',
      where: 'is_synced = ?',
      whereArgs: [0],
    );
    return maps.map((map) => FirestoreProduct.fromJson(map)).toList();
  }

  Future<void> updateIsSynced(int productId) async {
    final db = await database;
    await db.update(
      'local_cart',
      {'is_synced': 1},
      where: 'id = ?',
      whereArgs: [productId],
    );
  }
}