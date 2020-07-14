import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods{
  getUserByUsername(String username)async{
    return Firestore.instance.collection("users").where("name", isEqualTo: username)
    .getDocuments();


  }
  uploadUserInfo(userMap){
    Firestore.instance.collection("users")
    .add(userMap).catchError((e){
      print(e.toString());
    });


  }
  createChatRoom(String chatRoomid, chatRoomMap){
    Firestore.instance.collection("ChatRoom").document(chatRoomid).setData(chatRoomMap).catchError((e){
      print (e.toString());
    });
  }
}