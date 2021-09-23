import 'dart:io';

import 'package:path/path.dart';
import "package:path_provider/path_provider.dart";
import 'package:shoping_cart/model/product_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "products.db";
  static const _databaseVersion = 1;
  static final table = 'product_table';
  static final columnProductId = 'prodId';
  static final columnTitle = 'title';
  static final columnDescription = 'description';
  static final columnPrice = 'price';
  static final columnImageUrl = "imageUrl";

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();
  Database? _database;
  get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    return await openDatabase(dbPath, version: _databaseVersion, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
     $columnProductId TEXT PRIMARY KEY,
     $columnTitle TEXT NOT NULL,
     $columnPrice TEXT  NOT NULL,
     $columnDescription TEXT NOT NULL,
     $columnImageUrl  TEXT NOT NULL
    )
   ''');
  }

  insertProduct(Product product) async {
    Database db = await instance.database;
    await db.insert(table, product.toJson());
  }

  deleteProducts() async {
    Database db = await instance.database;
    await db.delete(table);
  }

  Future<int> updateProduct(Product product) async {
    final db = await instance.database;

    return db.update(
      table,
      product.toJson(),
      where: '$table = ?',
      whereArgs: [product.prodId],
    );
  }

  Future<int> deleteProduct(int id) async {
    final db = await instance.database;
    return await db.delete(
      table,
      where: '$columnProductId = ?',
      whereArgs: [id],
    );
  }

  Future<List<Product>?> getProducts() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> products = await db.query(table);
    return products.length == 0 ? null : products.map((i) => Product.fromJson(i)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

