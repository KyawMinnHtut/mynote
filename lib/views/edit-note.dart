import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote/controller/note_controller.dart';
import 'package:mynote/database/database.dart';
import 'package:mynote/model/note.dart';

class NoteEdit extends StatelessWidget {
  NoteEdit({ Key? key }) : super(key: key);
  final NoteController controller = Get.find();
  int noteId = Get.arguments['id'];
  @override
  Widget build(BuildContext context) {
    controller.selectNoteByID(noteId);
    //String? title = noteList[id].title;
    //String? note = noteList[id].note;
    //log(title.toString());
    //log(note.toString());
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Note"), centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  controller: controller.titleTextController,//..text=noteList[id-1].title.toString(),
                  decoration: const InputDecoration(border: InputBorder.none,
                  hintText: 'Title',
                  contentPadding: EdgeInsets.all(4)),
                )),
            ),
            Expanded(child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                controller: controller.noteTextController,//..text=noteList[id-1].note.toString(),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration:  const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write Your Note',
                  contentPadding: EdgeInsets.all(4)),
              ))),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: (){
          controller.updateNotebyID(noteId);
          controller.clear();
          Get.toNamed('/home');
        },
        ),
      
    );
  }
}