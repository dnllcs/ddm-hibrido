import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Connection {
  static Database? _database;

  static Future<Database> initialize() async {
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
    if (_database != null) return _database!;

    //final directory = await getApplicationDocumentsDirectory();
    final path = join(await getDatabasesPath(), 'vertebrados.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE vertebrado(
            id INTEGER PRIMARY KEY,
            nome TEXT,
            idade INTEGER,
            especie TEXT,
            tipoEsqueleto TEXT,
            sangueQuente INTEGER,
            numeroMembros INTEGER
          )
        ''');
      },
    );
    return _database!;
  }

  static Future<Database> getDatabase() async {
    if (_database == null) {
      await initialize();
    }
    return _database!;
  }
}
