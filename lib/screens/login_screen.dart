import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_app/base/app_config.dart';
import 'package:note_app/base/utils.dart';
import 'package:note_app/exceptions/http_exception.dart';
import 'package:note_app/providers/auth.dart';
import 'package:note_app/screens/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String routeName ="/login-screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appBar =AppBar(
      title: Text(AppConfig.appName),
    );
    return Scaffold(
       appBar: appBar,
      body: isLoading ? Center(
        child: CircularProgressIndicator(),
      )
       : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
            padding: EdgeInsets.all(15)
            ,child: Image.asset("assets/images/note_image.png",
                  height: (MediaQuery.of(context).size.height - appBar.preferredSize.height) * 0.27),
            ),
            Padding(
             padding: EdgeInsets.all(15)
            ,child: Card(
                child: Container(
                   height: 300,
                   margin: EdgeInsets.all(15),
                   padding: EdgeInsets.all(15),
                   child: Column(
                     children: <Widget>[
                       TextField(
                         decoration: InputDecoration(
                           labelText: "Enter Email",
                           icon: Icon(Icons.email),
                         ),
                         keyboardType: TextInputType.emailAddress,
                         controller: _emailController,
                       ),
                       TextField(
                           decoration: InputDecoration(
                               labelText: "Enter Password",
                               icon: Icon(Icons.vpn_key)
                           ),
                         obscureText: true,
                         keyboardType: TextInputType.visiblePassword,
                         controller: _passwordController,
                       ),
                       SizedBox(height: 15,),
                       FlatButton(
                           child: Text("SignIn",
                           style: TextStyle(
                             color: Theme.of(context).accentColor,
                             fontSize: 16,
                           )
                           ),
                           onPressed: _loginUser,
                         ),
                       FlatButton(
                         child: Text("Not registered yet ? Signup",
                             style: TextStyle(
                               color: Theme.of(context).accentColor
                             )
                         ),

                         onPressed: (){
                            Navigator.of(context).pushNamed(RegisterScreen.routeName);
                         },
                       )
                     ],
                   ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _loginUser() async{
   final email =  _emailController.text;
   final password = _passwordController.text;
   if(email.isEmpty) return showMessageDialog(context,"Please provide email");
   if(password.isEmpty) return showMessageDialog(context,"Please provide password");
   setState(() {
     isLoading = true;
   });
   try {
     await Provider.of<Auth>(context, listen: false)
         .loginUser(email, password);
   }on HttpException catch(httpEx){
       showMessageDialog(context, httpEx.toString(),()=> _passwordController.text ="");
   }catch(e){
     showErrorMessage(context);
   }finally {
     setState(() {
       isLoading = false;
     });
   }
  }


}
