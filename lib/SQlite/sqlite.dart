import 'package:path/path.dart';
import 'package:phone_list_app/models/noteModel.dart';
import 'package:phone_list_app/models/UserModel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final databaseName = "note.db";
  String noteTable = "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, userId INTEGER, FOREIGN KEY(userId) REFERENCES users(id) ON DELETE CASCADE)";
  String userTable = "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT UNIQUE, password TEXT)";
  int version = 2;

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    
    return openDatabase(path, version: version,
        onCreate: (db, version) async {
      await db.execute(userTable);
      await db.execute(noteTable);
    },

    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < version) {
        await db.execute("DROP TABLE IF EXISTS notes");
        await db.execute("DROP TABLE IF EXISTS users");
        await db.execute(userTable);
        await db.execute(noteTable);
      }
    });
  }

  Future<int?> loginDb(String email, String password) async {
    final Database db = await initDB();

    var res = await db.query(
      'users',
      columns: ['id'],
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (res.isNotEmpty) {
      return res.first['id'] as int?;
    }
    return null;
  }

  Future<int?> signUpDb(String email, String password) async {
    final Database db = await initDB();
    UserModel user = UserModel(
      email: email,
      password: password
    );

    try {
      var id = await db.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      return id > 0 ? id : null;
    } catch (e) {
      print("Błąd rejestracji: ${e.toString()}");
      return null;
    }
  }


  //Note CRUD

  Future<int> createNote(NoteModel note) async {
    final Database db = await initDB();
    return db.insert('notes', note.toMap());
  }

  Future<List<NoteModel>> getNotes(int userId) async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query(
      'notes',
      where: 'userId = ?',
      whereArgs: [userId]
    );
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  Future<int> deleteNote(int id) async {
    final Database db = await initDB();
    return db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateNote(title, content, noteId) async {
    final Database db = await initDB();
    return db.rawUpdate(
      "update notes set title = ?, content = ? where id = ?",
        [title, content, noteId]);
  }

}




