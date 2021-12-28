import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mynote/controller/note_controller.dart';
import 'package:mynote/enums/menu_item.dart';
import 'package:get/get.dart';
import 'package:mynote/model/note.dart';
import 'package:mynote/views/widgets/trim_String.dart';
import 'package:search_page/search_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({ Key? key }) : super(key: key);
  final NoteController controller = Get.put(NoteController());
  @override
  Widget build(BuildContext context) {
    var noteList = controller.notes;
    return Scaffold(
      appBar: AppBar(
        title:  Text("My Notes"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              showSearch(
                context: context, 
                delegate: SearchPage<Note>(
                  searchLabel: 'Search Notes',
                  suggestion: const Center(
                    child: Text('Search notes by title or note')
                  ),
                  failure: Center(
                    child: Text('No notes found'),
                  ),
                  builder: (note)=> ListTile(
                    title: Text(note.title.toString()),
                    subtitle: Text(note.note.toString()),
                    trailing: Text(note.notedAt.toString()),

                  ), 
                  filter: (note)=>[
                    note.title,
                    note.note,
                  ], 
                  items: controller.notes));
            }, 
            icon: const Icon(Icons.search)
            ),
          PopupMenuButton(
            onSelected: (value)=>{value == 1 ? Get.toNamed('/about') : launch('https://github.com/b14cknc0d3/note') },//()=>{launch('https://github.com/b14cknc0d3/note')},
            itemBuilder: (BuildContext context)=>[
              const PopupMenuItem(
                value: 1,
                child: Text("About App")),
              const PopupMenuItem(
                value: 2,
                child: Text("Github")),
            ]),
        ],
      ),
      drawer: Drawer(
        //semanticLabel: 'Note',
        child: ListView(
          children: [
            // ListTile(
            //   trailing: Icon(Icons.settings),
            //   onTap: (){},
            // ),
            ListTile(
              leading: Icon(Icons.file_copy),
              title: Text("Notes"),
              onTap: (){
                //Get.back();
                Navigator.pop(context);
                },
            ),
            // ListTile(
            //   leading: Icon(Icons.folder),
            //   title: Text("Folder"),
            //   onTap: (){},
            // ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("My Favourite"),
              onTap: (){
                Navigator.pop(context);
                Get.toNamed('/fav');
                },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Recycle Bin"),
              onTap: (){
                Navigator.pop(context);
                Get.toNamed('/del');},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.delete_forever),
              title: Text("Clear All Notes"),
              onTap: (){
                Navigator.pop(context);
                Get.defaultDialog(
                  title: 'Are you sure to DELETE ALL NOTES',
                  confirm: ElevatedButton(
                    onPressed: (){
                      controller.deleteAllNotes(); 
                      Get.back();
                      Get.snackbar('Success', 'All notes deleted');},
                    child: Text('DELETE')),
                  cancel: ElevatedButton(onPressed: (){Get.back();}, child: Text('Cancel')),
                );
              },
            ),
          ],
        ),
      ),
      body: Obx(()=>ListView.builder(
        itemCount: controller.notes.length,
        itemBuilder: (context, index){
          log("values from controller=>" + noteList.toString());
        return InkWell(
          onTap: (){
            Get.toNamed('/edit', arguments: {'id': noteList[index].id});
          },
          child: ListTile(
            title: Text(trimString(noteList[index].title.toString())),
            subtitle: Text(trimString(noteList[index].note.toString())),
            // isThreeLine: true,
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
                    controller.moveToTrash(
                      noteList[index].id!, 
                      noteList[index].isinTrash == 0? 1 :0);
                    //controller.deleteNoteByID(noteList[index].id!);
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          controller.clear();
          Get.toNamed('/add');
        },
      ),
    );
  }
}