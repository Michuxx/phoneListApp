class NoteModel {
  final int? id;
  final String title;
  final String content;

  NoteModel({
     this.id,
    required this.title,
    required this.content,
  });

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
    id: json["Id"],
    title: json["title"],
    content: json["content"],
  );

  Map<String, dynamic> toMap() => {
    "Id": id,
    "title": title,
    "content": content,
  };
}
