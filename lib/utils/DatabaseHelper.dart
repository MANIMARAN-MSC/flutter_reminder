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
    final path = join(dbPath, 'events.db');

    return openDatabase(
      path,
      version: 2, // Increment version to alter table
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE events(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            event TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE teachers(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            phone TEXT,
            email TEXT,
            address TEXT,
            imagePath TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE teachers(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              phone TEXT,
              email TEXT,
              address TEXT,
              imagePath TEXT
            )
          ''');
        }
      },
    );
  }


  Future<void> insertEvent(String date, String event) async {
    final db = await database;
    await db.insert(
      'events',
      {'date': date, 'event': event},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getEvents(String date) async {
    final db = await database;
    return await db.query('events', where: 'date = ?', whereArgs: [date]);
  }

  Future<void> deleteEvent(int id) async {
    final db = await database;
    await db.delete('events', where: 'id = ?', whereArgs: [id]);
  }

  // Insert teacher
  Future<int> insertTeacher(Map<String, dynamic> teacher) async {
    final db = await database;
    return await db.insert("teachers", teacher);
  }

  // Fetch all teachers
  Future<List<Map<String, dynamic>>> getTeachers() async {
    final db = await database;
    return await db.query("teachers");
  }

  Future<void> updateTeacher(int id, Map<String, dynamic> teacher) async {
    final db = await database;
    await db.update(
      "teachers",
      teacher,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Delete a teacher by ID
  Future<void> deleteTeacher(int id) async {
    final db = await database;
    await db.delete("teachers", where: "id = ?", whereArgs: [id]);
  }
}
