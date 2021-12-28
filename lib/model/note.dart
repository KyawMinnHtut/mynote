class Note {
  int? id;
  String? title;
  String? note;
  String? notedAt;
  int? isinTrash;
  int? favourite;

  Note({
      this.id,
      this.title,
      this.note,
      this.notedAt,
      this.isinTrash,
      this.favourite,
    }
  );
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'note': note,
      'notedAt': notedAt,
      'isinTrash': isinTrash,
      'favourite': favourite
    };
  }

  @override 
  String toString() {
    return "Note{id: $id, title: $title, note: $note, notedAt: $notedAt, favourite: $favourite, isInTrash: $isinTrash}";
  }
}