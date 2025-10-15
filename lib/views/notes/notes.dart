import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_list_app/SQlite/sqlite.dart';
import 'package:phone_list_app/models/noteModel.dart';

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
  late DatabaseHelper handler;
  late Future<List<NoteModel>> notes;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHelper();
    notes = handler.getNotes(widget.userId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notatki"),
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
              return ListView.builder(itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].title),
                );
              });
            }
      }),
    );
  }
}
