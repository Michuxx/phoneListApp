import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_list_app/SQlite/sqlite.dart';

class UpdateNote extends StatefulWidget {

  final int noteId;
  final String noteTitle;
  final String contentTitle;

  const UpdateNote({
    super.key,
    required this.noteId,
    required this.noteTitle,
    required this.contentTitle,
  });

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {

  late final TextEditingController title;
  late final TextEditingController content;

  final db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.noteTitle);
    content = TextEditingController(text: widget.contentTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Twoja notatka"),
        actions: [IconButton(
            onPressed: () {
              db.updateNote(title.text, content.text, widget.noteId).whenComplete(() {
                Navigator.of(context).pop(true);
              });
            },
            icon: Icon(Icons.check))],
      ),
      body: Form(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Brakuje tytułu";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text("Tytuł"),
                  ),
                ),
                TextFormField(
                  controller: content,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    label: Text("Treść"),
                  ),
                )
              ],),
          )),
    );
  }
}
