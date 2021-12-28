import 'package:get/get.dart';
import 'package:mynote/controller/note_controller.dart';

class NoteBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => NoteController());
  }
}