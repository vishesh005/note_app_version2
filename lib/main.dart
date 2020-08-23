import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_app/base/app_config.dart';
import 'package:note_app/providers/auth.dart';
import 'package:note_app/providers/auth.dart';
import 'package:note_app/providers/notes.dart';
import 'package:note_app/screens/home.dart';
import 'package:note_app/screens/login_screen.dart';
import 'package:note_app/screens/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/Note.dart';

void main() async {
  runApp(NoteAppV2());
}

class NoteAppV2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth,Notes>(
          builder: (ctx,auth,prevNotes){
             return Notes(
               auth.token,
               auth.userId,
               prevNotes != null ? prevNotes.notes :[
                 Note(
                     id: "a",
                     title: "Note a",
                     body: "Note a body ",
                     createdAt: DateTime.now(),
                     modifiedAt: DateTime.now()
                 ),
                 Note(
                     id: "b",
                     title: "Note b",
                     body: "Note b body ",
                     createdAt: DateTime.now(),
                     modifiedAt: DateTime.now()
                 ),
                 Note(
                     id: "a",
                     title: "Note a",
                     body: "Note a body ",
                     createdAt: DateTime.now(),
                     modifiedAt: DateTime.now()
                 ),
                 Note(
                     id: "b",
                     title: "Note b",
                     body: "Note b body ",
                     createdAt: DateTime.now(),
                     modifiedAt: DateTime.now()
                 ),
                 Note(
                     id: "a",
                     title: "Note a",
                     body: "Note a body ",
                     createdAt: DateTime.now(),
                     modifiedAt: DateTime.now()
                 ),
                 Note(
                     id: "b",
                     title: "Note b",
                     body: "Note b body ",
                     createdAt: DateTime.now(),
                     modifiedAt: DateTime.now()
                 ),
                 Note(
                     id: "a",
                     title: "Note a",
                     body: "Note a body ",
                     createdAt: DateTime.now(),
                     modifiedAt: DateTime.now()
                 ),
                 Note(
                     id: "b",
                     title: "Note b",
                     body: "Note b body ",
                     createdAt: DateTime.now(),
                     modifiedAt: DateTime.now()
                 )
               ]
             );
          },
        )
      ],
      child: Consumer<Auth>(builder: (ctx, authData, _) {
        return MaterialApp(
          home:FutureBuilder<void>(
                 future: authData.autoLogin(),
                 builder: (ctx, snapShot) {
                   if(snapShot.connectionState == ConnectionState.waiting) {
                    return Center(
                       child: CircularProgressIndicator());
                   }
                   else {
                     return authData.isAuth ? HomeScreen() : LoginScreen() ;
                   }
                 }
          ),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: AppConfig.primarySwatch,
            accentColor: AppConfig.accentColor,
          ),
          routes: {RegisterScreen.routeName: (ctx) => RegisterScreen()},
        );
      }),
    );
  }
}
