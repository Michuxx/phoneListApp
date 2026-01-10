import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_list_app/SQlite/sqlite.dart';
import 'package:phone_list_app/models/noteModel.dart';
import 'package:phone_list_app/services/sessionManager/sessionManager.dart';
import 'package:phone_list_app/views/notes/createNote.dart';
import 'package:phone_list_app/views/notes/updateNote.dart';
import 'package:phone_list_app/views/signIn/signIn.dart';

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

  void logout() async {
    await SessionManager.clearSession();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignIn()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notatki"),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Wyloguj się',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNote(userId: widget.userId)))
              .then((value) {
            if (value != null && value) {
              refreshNotes();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<NoteModel>>(
          future: notes,
          builder: (BuildContext context, AsyncSnapshot<List<NoteModel>> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(
                  child: Text(
                    "Brak notatek",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28
                    ),
                  ));
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              final items = snapshot.data ?? <NoteModel>[];
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index].title),
                      trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            deleteNote(items[index].id);
                          }),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateNote(
                            noteTitle: items[index].title,
                            contentTitle: items[index].content,
                            noteId: items[index].id as int
                        ))).then((value) {
                          if (value != null && value) {
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
