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
  final formKey = GlobalKey<FormState>();


  final db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stwórz notatkę"),
        actions: [IconButton(
            onPressed: () {
              db.createNote(NoteModel(title: title.text, content: content.text, userId: widget.userId)).whenComplete(() {
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
                  decoration: InputDecoration(
                    label: Text("Tytuł"),
                  ),
                )
              ],),
          )),
    );
  }
}
