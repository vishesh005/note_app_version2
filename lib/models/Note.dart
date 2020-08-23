import 'package:flutter/cupertino.dart';
import 'package:random_color/random_color.dart';

class Note extends ChangeNotifier{
  final String id;
  final String title;
  final String body;
  final String createdBy;
  final DateTime createdAt;
  final DateTime modifiedAt;
  Color noteDesignColor;

   Note({
   @required this.id,
   @required this.title,
   @required this.body,
   @required this.createdBy,
   @required this.createdAt,
   @required this.modifiedAt,
   this.noteDesignColor
   }){
     if(noteDesignColor == null){
       noteDesignColor = RandomColor().randomColor(
         colorBrightness: ColorBrightness.dark
       );
     }
   }



 Note updateNote({title,body,modifiedAt}){
   return Note(
         id: this.id,
         createdAt: this.createdAt,
         createdBy: this.createdBy,
         title: title != null ? title :this.title,
         body: body != null ? body : this.body,
         modifiedAt: modifiedAt != null ? modifiedAt :modifiedAt
    );
 }

 Map<String,dynamic> toMap(){
   return {
     "id":id,
     "title":title,
     "body":body,
     "createdBy":createdBy,
     "createdAt": createdAt.toIso8601String(),
     "modifiedAt":modifiedAt.toIso8601String()
   };
 }

 static Note fromMap(Map<String,dynamic> noteMap){
    return Note(
     id: noteMap["id"],
     title: noteMap["title"],
     body: noteMap["body"],
     createdBy: noteMap["createdBy"],
     createdAt: DateTime.parse(noteMap["createdAt"]),
     modifiedAt: DateTime.parse(noteMap["modifiedAt"])
    );
  }

 static List<Note> fromMapOfMap(Map<String,dynamic> notesMap){
    //notesMap.entries.map((note) => )
 }

}