import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/models/Note.dart';
import 'package:provider/provider.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final note =  Provider.of<Note>(context,listen: false);
    return Card(
      child: GridTile(
        header: Padding(
          padding: EdgeInsets.all(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween
            ,children: <Widget>[
            Flexible(
              flex: 1
              ,child: CircleAvatar(
              backgroundColor: note.noteDesignColor,
              child: Text(note.title[0].toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
              radius: 20,
            ),
            ),
            Flexible(
              flex: 3
              ,child: Text(note.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            ),
            Flexible(
              flex: 1
              ,child: Icon(Icons.edit,
              color: note.noteDesignColor,
            ),
            )
          ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 55, horizontal: 10)
          ,child: Text(note.body,
          style: TextStyle(
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
        ),
        ),
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 1
              ,child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10)
              ,child: IconButton(
              icon: Icon(Icons.favorite_border,
              color: note.noteDesignColor,
            ),
              onPressed: (){
                //here select favorites
              },
            ),
            ),
            )
            ,Flexible(
              flex: 3
              ,child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10)
              ,child: Text(DateFormat.yMd().format(note.modifiedAt),
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey
              ),
            ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}