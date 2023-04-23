import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/models/local_models/local_wiki_item.dart';
import 'tables/wiki_table.dart';

class DatabaseHelper {
  static const _databaseName = 'clockster_db';
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ?? await _initDatabase();

  Future<Database> _initDatabase() async {
    // Get the documents directory.
    final documentsDirectory = await getApplicationDocumentsDirectory();
    // Construct the path to the database file.
    final databasePath = join(documentsDirectory.path, _databaseName);
    // Open/create the database at the constructed path.
    return openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await _createWikiListTable(db);
  }

  Future<void> _createWikiListTable(Database db) async {
    await db.execute('''
    CREATE TABLE ${WikiTable().table} (
      ${WikiTable().columnPageID} INTEGER PRIMARY KEY,
      ${WikiTable().columnTitle} TEXT NOT NULL,
      ${WikiTable().columnDescription} TEXT NOT NULL,
      ${WikiTable().columnDetail} TEXT,
      ${WikiTable().columnThumbnail} TEXT
    )
  ''');
  }

  /// wont be functional here
  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    final Map<int, Function(Database)> migrationFunctions = {};

    if (newVersion <= oldVersion) {
      return;
    }

    for (int i = oldVersion + 1; i <= newVersion; i++) {
      final migrationFunction = migrationFunctions[i];
      if (migrationFunction == null) {
        throw Exception('Error: Migration function for version $i not found.');
      }
      migrationFunction(db);
    }
  }

  /// -------------------- DB OPERATIONS -------------------

  Future<void> storeWikiList(List<LocalWikiItem> list) async {
    final Database db = await instance.database;
    final batch = db.batch();
    for (final element in list) {
      batch.insert(
        WikiTable().table,
        element.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<LocalWikiItem>> queryWikiList(String query) async {
    final Database db = await instance.database;
    final response = await db.query(
      WikiTable().table,
      where: '${WikiTable().columnTitle} LIKE ?',
      whereArgs: ['%$query%'],
    );

    final List<LocalWikiItem> wikiList = response.isNotEmpty
        ? response.map((e) => LocalWikiItem.fromJson(e)).toList()
        : [];

    return wikiList;
  }

  Future<void> storeWikiDetail(int pageID, String detail) async {
    final Database db = await instance.database;
    final rowList = await db.query(
      WikiTable().table,
      where: '${WikiTable().columnPageID} LIKE ?',
      whereArgs: ['%$pageID%'],
    );
    if (rowList.isNotEmpty) {
      var row = LocalWikiItem.fromJson(rowList[0]);
      row.detail = detail;

      await db.update(
        WikiTable().table,
        row.toJson(),
        where: '${WikiTable().columnPageID} = ?',
        whereArgs: [pageID],
      );
    } else {
      return Future.value();
    }
  }

  Future<String?> getWikiDetail(int pageID) async {
    final Database db = await instance.database;
    final rowList = await db.query(
      WikiTable().table,
      where: '${WikiTable().columnPageID} LIKE ?',
      whereArgs: ['%$pageID%'],
    );

    if (rowList.isNotEmpty) {
      final wikiItem = LocalWikiItem.fromJson(rowList[0]);
      return wikiItem.detail;
    }
    return null;
  }
}
