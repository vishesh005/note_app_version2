import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_app/base/constants.dart';
import 'package:note_app/providers/auth.dart';
import 'package:note_app/providers/notes.dart';
import 'package:note_app/widgets/note_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await Provider.of<Auth>(context, listen: false).logoutUser();
            },
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            label: Text(
              logOut,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: NotesWidget(),
    );
  }
}

class NotesWidget extends StatefulWidget {
  @override
  _NotesWidgetState createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Notes>(
        future: Provider.of<Notes>(context, listen: false).fetchAllNotes(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapShot.error != null) {
            return Container(
              color: Colors.red,
            );
          } else {
            final notes = snapShot.data.notes;
            return Padding(
               padding: EdgeInsets.all(7)
              ,child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3.5 / 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: notes.length,
                  itemBuilder: (ctx, position) {
                    final note = notes[position];
                    return ChangeNotifierProvider.value(
                         value: note
                        ,child: NoteCardWidget());
                  }),
            );
          }
        });
  }
}


