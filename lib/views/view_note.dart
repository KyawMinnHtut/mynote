import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote/controller/note_controller.dart';
import 'package:mynote/database/database.dart';

class NoteView extends StatelessWidget {
  NoteView({ Key? key }) : super(key: key);
  final NoteController controller = Get.find();
  int id = Get.arguments['id'];
  @override
  Widget build(BuildContext context) {
    var noteList = controller.notes;
    log(id.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(noteList[id-1].title.toString()),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Get.toNamed('/edit', arguments: {'id': id});
          }, icon: Icon(Icons.edit),)
        ],
        ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //Text('createddate'),
            Text(noteList[id-1].note.toString()),
          ],
        ),
      ),
    );
  }
}