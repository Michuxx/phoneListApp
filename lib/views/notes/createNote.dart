import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_list_app/SQlite/sqlite.dart';
import 'package:phone_list_app/models/noteModel.dart';

class CreateNote extends StatefulWidget {

  final int userId;

  const CreateNote({
    super.key,
    required this.userId
  });

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final title = TextEditingController();
  final content = TextEditingController();
  String? titleError;
  String? contentError;

  final db = DatabaseHelper();

  bool titleValidation(input) {
    if (input == null || input == "") {
      setState(() {
        titleError = "tytuł nie może być pusty!";
      });
      return false;
    } else {
      setState(() {
        titleError = null;
      });
      return true;
    }
  }

  bool contentValidation(input) {
    if (input == null || input == "") {
      setState(() {
        contentError = "treść nie może być pusta!";
      });
      return false;
    } else {
      setState(() {
        contentError = null;
      });
      return true;
    }
  }

  void saveNote() {
    final isTitleValid = titleValidation(title.text);
    final isContentValid = contentValidation(content.text);

    if (isTitleValid && isContentValid) {
      db.createNote(NoteModel(
        title: title.text,
        content: content.text,
        userId: widget.userId,
      )).whenComplete(() {
        Navigator.of(context).pop(true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stwórz notatkę"),
        actions: [IconButton(
            onPressed: saveNote,
            icon: Icon(Icons.check))],
      ),
      body: Form(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                    label: Text("Tytuł"),
                    errorText: titleError
                  ),
                ),
                TextFormField(
                  controller: content,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    label: Text("Treść"),
                    errorText: contentError
                  ),
                )
              ],),
          )),
    );
  }
}
