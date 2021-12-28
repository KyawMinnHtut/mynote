import 'dart:developer';
import 'dart:io';

import 'package:mynote/model/note.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static const _databaseName = "note.db";
  static const _databaseVersion = 1;
  static const table = 'Notedb';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnNote = 'note';
  static const columnNotedAt = 'notedAt';
  static const columnFavourite = 'favourite';
  static const columnIsInTrash = 'isInTrash';


  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String dataPath = p.join(dbPath, _databaseName);
    //print(dataPath);

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentsDirectory.path, _databaseName);
    //print(path);
    return await openDatabase(dataPath,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table(
	  $columnId INTEGER PRIMARY KEY,
    $columnTitle  TEXT,
    $columnNote TEXT,
    $columnNotedAt VARCHAR(10),
    $columnFavourite INTEGER NOT NULL DEFAULT 0,
    $columnIsInTrash INTEGER NOT NULL DEFAULT 0
    )''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<void> insertNote(Note note) async {
    Database db = await instance.database;
    await db.insert(
      table, 
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, nullColumnHack: "");
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Note>> queryAllNotes() async {
    Database db = await instance.database;
    //final data = await db.query(table);
    final List<Map<String, dynamic>> notes = await db.query(table);
    log("values from database of allNotes=>" + notes.toString());
    return List<Note>.generate(notes.length, (i){
      return Note(
        id: notes[i]['id'],
        title: notes[i]['title'],
         note: notes[i]['note'],
         notedAt: notes[i]['notedAt'],
         favourite: notes[i]['favourite'],
         isinTrash: notes[i]['isInTrash']
         );
    });
  }

  Future<List<Note>> queryAllUndeletedNotes() async {
    Database db = await instance.database;
    //final data = await db.query(table);
    final List<Map<String, dynamic>> notes = await db.query(table, where: '$columnIsInTrash=?', whereArgs: [0]);
    log("values from database of allUndel=>" + notes.toString());
    return List<Note>.generate(notes.length, (i){
      return Note(
        id: notes[i]['id'],
        title: notes[i]['title'],
         note: notes[i]['note'],
         notedAt: notes[i]['notedAt'],
         favourite: notes[i]['favourite'],
         isinTrash: notes[i]['isInTrash']
         );
    });
  }

  Future<List<Note>> queryAllFavNotes() async {
    Database db = await instance.database;
    //final data = await db.query(table);
    final List<Map<String, dynamic>> notes = await db.query(table, where: '$columnFavourite=?', whereArgs: [1]);
    log("values from database of allFav=>" + notes.toString());
    return List<Note>.generate(notes.length, (i){
      return Note(
        id: notes[i]['id'],
        title: notes[i]['title'],
         note: notes[i]['note'],
         notedAt: notes[i]['notedAt'],
         favourite: notes[i]['favourite'],
         isinTrash: notes[i]['isInTrash']
         );
    });
  }
  Future<List<Note>> queryAllDeletedNotes() async {
    Database db = await instance.database;
    //final data = await db.query(table);
    final List<Map<String, dynamic>> notes = await db.query(table, where: '$columnIsInTrash=?', whereArgs: [1]);
    log("values from database of allDel=>" + notes.toString());
    return List<Note>.generate(notes.length, (i){
      return Note(
        id: notes[i]['id'],
        title: notes[i]['title'],
         note: notes[i]['note'],
         notedAt: notes[i]['notedAt'],
         favourite: notes[i]['favourite'],
         isinTrash: notes[i]['isInTrash']
         );
    });
  }

  Future updateNotebyID(int id, String title, String note, String notedAt) async{
  //Get a reference to the database.
  Database db = await instance.database;
  log(id.toString());
  //Update the given Note.
  return await db.rawUpdate('UPDATE $table SET $columnTitle = ?, $columnNote = ?, $columnNotedAt = ? where $columnId = ?', [title, note, notedAt, id ]);
  }

  Future updateFav(int id, int value) async{
    Database db = await instance.database;
    return await db.rawUpdate('UPDATE $table SET $columnFavourite = ? where $columnId = ?', [value, id]);
  }

  Future moveToTrash(int id, int value) async{
    Database db = await instance.database;
    return await db.rawUpdate('UPDATE $table SET $columnIsInTrash = ? where $columnId = ?', [value, id]);
  }
  // Future updateNotebyID(Note note, int id) async{
  //   //Get a reference to the database.
  //   Database db = await instance.database;
  //   log(id.toString());
  //   //Update the given Note.
  //   return await db.update(
  //     table, 
  //     note.toMap(),
  //     where: '$columnId = ?',
  //     whereArgs: [note.id],
  //     );
  // }

  Future<Note> selectNoteByID(int id) async{
    //Get a reference to the database.
    Database db = await instance.database;
    final List<Map<String, Object?>> notes = await db.query(table, where: '$columnId = ?', whereArgs: [id]);
    return Note(
        id: id,
        title: notes[0]['title'].toString(),
         note: notes[0]['note'].toString(),
         );
  }

  Future deleleAllNotes() async {
    Database db = await instance.database;
    return await db.delete(table);
  }
 
  Future<void> deleteNoteByID(int id) async{
    Database db = await instance.database;
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }


}