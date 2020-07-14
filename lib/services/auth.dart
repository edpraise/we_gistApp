import 'package:firebase_auth/firebase_auth.dart';
import 'package:gist_me/model/user.dart';

class AuthMethods{
  final FirebaseAuth _auth= FirebaseAuth.instance;
//Conditions if true the first statement will be called  else otherwise 
  User _userfromfirebaseUser(FirebaseUser user){
    return user !=null ? User(userId: user.uid): null;
  }

  Future signInWithEmailAndPassword(String email, String password)async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword
      (email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userfromfirebaseUser(firebaseUser);
    }catch(e){
      print(e.toString());

    }
  }
  Future signUpWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword
      (email: email, password:password);
      FirebaseUser firebaseUser = result.user;
      return _userfromfirebaseUser(firebaseUser);
    }catch(e){
      print(e.toString());
    }
  }
  Future resetPassword(String email,) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){

    }
  }
}