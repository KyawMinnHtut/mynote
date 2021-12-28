import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mynote/database/database.dart';
import 'package:mynote/model/note.dart';

class NoteController extends GetxController{
  RxList<Note> notes = <Note>[].obs;
  RxList<Note> favNotes = <Note>[].obs;
  RxList<Note> delNotes = <Note>[].obs;
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController noteTextController = TextEditingController();
  final _db = DatabaseHelper.instance;
  @override
  void onInit() {
    // TODO: implement onInit
    getAllUndeletedNote();
    getAllDeletedNote();
    getAllFavNote();
    super.onInit();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    titleTextController.dispose();
    noteTextController.dispose();
    super.onClose();
  }
  addNote(){
    if(titleTextController.text.isNotEmpty && noteTextController.text.isNotEmpty){
      Note note = Note(
      title: titleTextController.text,
      note: noteTextController.text,
      notedAt: DateTime.now().toString().substring(0,10),
      );
      _db.insertNote(note);
      getAllUndeletedNote();
    }
    else {
      getAllUndeletedNote();
    }
  }

  //getAllNote must be called in every controller to update UI.
  // getAllNote() async{
  //   List<Note> noteList = await _db.queryAllNotes();
  //   notes.value = noteList;
  // }

  //get all notes from database, except moveToTrash notes, to show on home screen
  getAllUndeletedNote() async{
    List<Note> noteList = await _db.queryAllUndeletedNotes();
    notes.value = noteList;
  }
  
  //get all favourite notes for FavScreen
  getAllFavNote() async{
    List<Note> noteList = await _db.queryAllFavNotes();
    favNotes.value = noteList;
  }
  
  //get all moveToTrash notes for DelScreen
   getAllDeletedNote() async{
    List<Note> noteList = await _db.queryAllDeletedNotes();
    delNotes.value = noteList;
  } 
  //to clear the state of screen
  clear(){
    titleTextController.clear();
    noteTextController.clear();
  }

  //to update note
  updateNotebyID(int id) {
    Note note = Note(
      id: id,
      title: titleTextController.text,
      note: noteTextController.text,
      notedAt: DateTime.now().toString(),
    );
    _db.updateNotebyID(id, note.title!, note.note!, note.notedAt!);
    getAllUndeletedNote();
  }

  //to check favourite or not
  updateFav(int id, int value) {
    // Note note = Note(
    //   id: id,
    //   favourite: value,
    // );
    _db.updateFav(id, value);
    getAllUndeletedNote();
    getAllFavNote();
  }

  //move to trash
  moveToTrash(int id, int value) {
    // Note note = Note(
    //   id: id,
    //   isinTrash: value,
    // );
    _db.moveToTrash(id, value);
    getAllUndeletedNote();
    getAllDeletedNote();
  }

  //to select note by ID
  selectNoteByID(int id) async{
    var note = await _db.selectNoteByID(id);
    titleTextController.text = note.title.toString();
    noteTextController.text = note.note.toString();
    
  }

  //delete note by ID
  deleteNoteByID(int id) async{
    await _db.deleteNoteByID(id);
    getAllUndeletedNote();
    getAllDeletedNote();
  }

  //delete all notes
  deleteAllNotes() async{
    await _db.deleleAllNotes();
    getAllUndeletedNote();
    getAllDeletedNote();
  }
}