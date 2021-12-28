import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote/controller/note_controller.dart';
import 'package:mynote/views/widgets/trim_String.dart';

class DelScreen extends StatelessWidget {
  DelScreen({ Key? key }) : super(key: key);
  final NoteController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    var noteList = controller.delNotes;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deleted Notes'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
        ],
        ),
        body: Obx(()=>ListView.builder(
        itemCount: controller.delNotes.length,
        itemBuilder: (context, index){
        log("values from delcontroller=>" + noteList.toString());
        return InkWell(
          onTap: (){
            Get.toNamed('/edit', arguments: {'id': noteList[index].id});
          },
          child: ListTile(
            title: Text(trimString(noteList[index].title.toString())),
            subtitle: Text(trimString(noteList[index].note.toString())),
            isThreeLine: true,
            trailing: Row(
              //before using mainAxisSize.min, icon buttons take the whole place.
              mainAxisSize: MainAxisSize.min,
              children: [
              IconButton(onPressed: (){
                controller.updateFav(
                  noteList[index].id!, 
                  noteList[index].favourite == 0? 1 :0);
              }, icon: noteList[index].favourite == 0 ? const Icon(Icons.favorite_border) : const Icon(Icons.favorite)),
              IconButton(onPressed: (){
                Get.defaultDialog(
                  title: 'Are you sure to delete?',
                  content: Text(trimString(noteList[index].title.toString())),
                  confirm: ElevatedButton(onPressed: (){
                    // controller.moveToTrash(
                    //   noteList[index].id!, 
                    //   noteList[index].isinTrash == 0? 1 :0);
                    controller.deleteNoteByID(noteList[index].id!);
                    Get.back();
                  }, child: const Text('Delete')),
                  cancel: ElevatedButton(onPressed: (){
                    Get.back();
                  }, child: const Text('Cancel')),
                );
              }, icon: const Icon(Icons.delete)),
            ],),
          ),
        );
      })),
    );
  }
}