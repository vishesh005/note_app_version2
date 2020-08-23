import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/base/app_config.dart';
import 'package:note_app/exceptions/http_exception.dart';
import 'package:note_app/providers/auth.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {

  static final routeName ="/register-name";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController= TextEditingController();
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.appName),
      ),

      body: Padding(
        padding: EdgeInsets.all(30),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text("Sign up Here",
                     style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                       color: Theme.of(context).accentColor
                     ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Enter your email id"
                      ),
                      validator: (email){
                         if(email.isEmpty) return "Please provide email";
                         else if (!email.contains("@")) return "Please provide valid email";
                         else return null;
                      },
                        onSaved: (email) {
                           this.email = email;
                        }
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Enter your password"
                      ),
                        validator: (password){
                          if(password.isEmpty) return "Please provide password";
                          else if (password.length < 3) return "Password contains at least 3 character";
                          else return null;
                        },
                      controller: _passwordController,
                        onSaved: (password) {
                           this.password = password;
                        }
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Enter your confirm password"
                      ),
                        validator: (confirmPassword){
                          if(_passwordController.text != confirmPassword) return "Password & Confirm password are not matched";
                          else return null;
                        }
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      child: Text("Sign up",
                       style: TextStyle(
                         color: Theme.of(context).accentColor,
                         fontSize: 16
                       ),
                      ),
                      onPressed:_registerUser,
                    ),
                    SizedBox(height: 7,),
                    FlatButton(
                      child: Text("Already user ? SignIn",
                       style: TextStyle(
                         color: Theme.of(context).accentColor
                       ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              ),
            ),
          ),

        ),
      ),
    );
  }

  void _registerUser() {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    try {
      Provider.of<Auth>(context, listen: false).registerUser(email, password);
    } on HttpException catch(httpEx){

    }catch(e){

    }
  }
}
