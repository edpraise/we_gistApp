import 'package:flutter/material.dart';
import 'package:gist_me/helper/authentication.dart';
import 'package:gist_me/screens/search_screen.dart';
import 'package:gist_me/services/auth.dart';


class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
      "We Gist",
    ),
    actions: <Widget>[
      GestureDetector(
        onTap: (){
          authMethods.signOut();
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Authenticate()

          ));
        },
              child: Container(
          padding: EdgeInsets.symmetric(horizontal:16),
          child: Icon(Icons.exit_to_app)),
      )
    ],
      ),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder:(context) =>SearchScreen()

          ));
        },
      ),
    );

  }
}