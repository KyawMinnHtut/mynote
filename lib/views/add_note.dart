import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote/controller/note_controller.dart';

class NoteAdd extends StatelessWidget {
  NoteAdd({ Key? key }) : super(key: key);
  final NoteController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Note"), centerTitle: true,),
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
                  controller: controller.titleTextController,
                  decoration: InputDecoration(border: InputBorder.none,
                  hintText: 'Title',
                  contentPadding: EdgeInsets.all(4)),
                )),
            ),
            Expanded(child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                controller: controller.noteTextController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
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
          //to add note
          controller.addNote();
          //after adding note, to clear the controller
          controller.clear();
          //go back to home screen
          Get.back();
        },),
      
    );
  }
}