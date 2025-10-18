class NoteModel {
  final int? id;
  final String title;
  final String content;
  final int userId;

  NoteModel({
     this.id,
    required this.title,
    required this.content,
    required this.userId
  });

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
    id: json["id"] as int?,
    title: json["title"],
    content: json["content"],
    userId: json["userId"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "content": content,
    "userId": userId
  };
}
