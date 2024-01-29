import 'package:sqflite/sqflite.dart';

Future<Database> openDatabaseConnection() async {
  return openDatabase(
    'dbhelper.db',
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE api_data (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          json_data TEXT NOT NULL
        )
      ''');
    },
    version: 1,
  );
}
void insertApiData(Database db, String jsonData) async {
  await db.insert('api_data', {'json_data': jsonData});
}

Future<List<Map<String, dynamic>>> queryApiData(Database db) async {
  return await db.query('api_data');
}

Future<int> deleteApiData(Database db, int id) async {
  return await db.delete('api_data', where: 'id = ?', whereArgs: [id]);
}

