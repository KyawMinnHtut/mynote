import 'package:get/get.dart';
import 'package:mynote/controller/binding.dart';
//import 'package:mynote/views/about_app.dart';
import 'package:mynote/views/add_note.dart';
import 'package:mynote/views/drawer/deleted_note.dart';
import 'package:mynote/views/drawer/favourite_note.dart';
import 'package:mynote/views/edit-note.dart';
import 'package:mynote/views/home.dart';
import 'package:mynote/views/view_note.dart';

class MyRoutes {
  static final routes = [
    GetPage(name: "/home", page: ()=>HomeScreen(), binding: NoteBinding()),
    GetPage(name: "/add", page: ()=>NoteAdd(), binding: NoteBinding()),
    GetPage(name: "/view", page: ()=>NoteView(), binding: NoteBinding()),
    GetPage(name: '/edit', page: ()=>NoteEdit(), binding: NoteBinding()),
    GetPage(name: "/fav", page: ()=>FavScreen(), binding: NoteBinding()),
    GetPage(name: '/del', page: ()=>DelScreen(), binding: NoteBinding()),
    //GetPage(name: '/about', page: ()=>AboutApp()),

  ];
}