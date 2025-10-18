import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_list_app/SQlite/sqlite.dart';
import 'package:phone_list_app/models/noteModel.dart';
import 'package:phone_list_app/views/notes/createNote.dart';
import 'package:phone_list_app/views/notes/updateNote.dart';

class Notes extends StatefulWidget {
  final int userId;

  const Notes({
    super.key,
    required this.userId
  });

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final DatabaseHelper db = DatabaseHelper();
  late Future<List<NoteModel>> notes;

  @override
  void initState() {
    super.initState();
    notes = db.getNotes(widget.userId);
  }

  Future<void> refreshNotes() async {
    setState(() {
      notes = db.getNotes(widget.userId);
    });
  }

  void deleteNote(noteId) {
    db.deleteNote(noteId).whenComplete(() {
      refreshNotes();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notatki"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNote(userId: widget.userId)))
              .then((value) {
                if (value) {
                  refreshNotes();
                }
          });
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<NoteModel>>(
          future: notes,
          builder: (BuildContext context, AsyncSnapshot<List<NoteModel>> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                  "Brak notatek",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28
                    ),
              ));
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              final items = snapshot.data ?? <NoteModel>[];
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index].title),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteNote(items[index].id);
                          }),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateNote(
                            noteTitle: items[index].title,
                            contentTitle: items[index].content,
                            noteId: items[index].id as int
                        ))).then((value) {
                          if (value) {
                            refreshNotes();
                          }
                        });
                      },
                    );
                  });
            }
      }),
    );
  }
}
