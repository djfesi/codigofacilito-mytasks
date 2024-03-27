import 'package:sqflite/sqflite.dart';

class DbService {
  Database? _db;

  Future<void> open({required String dbName, required int version}) async {
    final path = await getDatabasesPath();
    _db = await openDatabase(
      '$path/$dbName',
      version: version,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE myTasks (id INTEGER PRIMARY KEY, title TEXT, description TEXT, created_at INTEGER)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < version) {
          await db.execute('ALTER TABLE myTasks ADD COLUMN created_at INTEGER');
        }
      },
    );
  }

  Future<int?> taskInsert(String tableName, Map<String, dynamic> values) async {
    try {
      values['created_at'] = DateTime.now().millisecondsSinceEpoch;
      final id = await _db!.insert(tableName, values);
      if (id == 0) {
        return null;
      }
      return id;
    } catch (_) {
      return null;
    }
  }

  Future<List<Map>?> tasksQuery(String tableName,
      {List<String>? columns}) async {
    try {
      final results = await _db!.query(tableName, columns: columns);
      return results;
    } catch (_) {
      return null;
    }
  }

  Future<int> taskDelete(String tableName,
      {String? where, List<Object?>? whereArgs}) async {
    try {
      final result =
          await _db!.delete(tableName, where: where, whereArgs: whereArgs);
      return result;
    } catch (_) {
      return 0;
    }
  }

  Future<int> taskUpdate(String tableName,
      {required Map<String, Object?> values,
      String? where,
      List<Object?>? whereArgs}) async {
    try {
      final result = await _db!
          .update(tableName, values, where: where, whereArgs: whereArgs);
      return result;
    } catch (_) {
      return 0;
    }
  }

  Future<void> close() async {
    await _db?.close();
  }
}
