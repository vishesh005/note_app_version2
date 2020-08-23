import 'package:flutter/material.dart';


Future<dynamic> showErrorMessage(BuildContext context) {
  return showDialog(context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Something went wrong !"),
          content: Text("There is an error.Please try again !"),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"))
          ],
        );
      }
  );
}

Future<dynamic> showMessageDialog(BuildContext context, String message,
    [Function action]) {
  return showDialog(context: context,
      builder: (ctx) {
        return AlertDialog(
            title: Text(message),
            actions: <Widget>[
            FlatButton(
            onPressed: ()
        {
          action();
          Navigator.of(context).pop();
        },
        child:
        Text("Ok")
        )
        ]
        ,
        );
      }
  );
}