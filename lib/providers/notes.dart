import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:note_app/base/app_config.dart';
import 'package:note_app/models/Note.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;


class Notes extends ChangeNotifier{
   final String _authToken;
   final String _userId;

  Notes(this._authToken,this._userId,this._notes);

  List<Note> _notes=[];


  List<Note> get notes {
    return [..._notes];
  }

  Future<void> addNote(String title,String body){
     final note = Note(
         id:Uuid().v4(),
         title: title,
         body: body,
         createdAt: DateTime.now(),
         modifiedAt: DateTime.now()
       );
   //  http.post(AppConfig.getMainDbUrl(_authToken,_userId))
  }

  Future<Notes> fetchAllNotes() async{
//    final response = await http.get(AppConfig.dbGetUrl(_authToken,_userId));
//    final responseMap = jsonDecode(response.body) as Map<String,dynamic>;
//    final notes = Note.fromMap(responseMap);

    return this;
  }



}