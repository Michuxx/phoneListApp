import 'package:path/path.dart';
import 'package:phone_list_app/models/noteModel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final databaseName = "note.db";
  String noteTable = "CREATE TABLE notes (Id INTEGER PRIMARY KEY AUTOINCREMENT, title TEX, content TEXT)";

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(noteTable);
    });
  }


  //Note CRUD

  Future<int> createNote(NoteModel note) async {
    final Database db = await initDB();
    return db.insert('notes', note.toMap());
  }

  Future<List<NoteModel>> getNotes() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('notes');
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  Future<int> deleteNote(int id) async {
    final Database db = await initDB();
    return db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateNote(title, content, noteId) async {
    final Database db = await initDB();
    return db.rawUpdate(
      "update notes set title = ?, content = ?, where id = ?",
        [title, content, noteId]);
  }

}




