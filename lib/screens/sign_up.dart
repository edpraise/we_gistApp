import 'package:flutter/material.dart';
import 'package:gist_me/screens/chat_screen.dart';
import 'package:gist_me/services/auth.dart';
import 'package:gist_me/services/database.dart';
import 'package:gist_me/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp (this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isloading = false;

  AuthMethods authMethods = new AuthMethods();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();

  final formkey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  signMeUp() {
    if (formkey.currentState.validate()) {

       Map<String, String>  userInfoMap ={
          "name" : userNameTextEditingController.text,
          "email" : emailTextEditingController.text,
        };
      setState(() {
        isloading = true;
      });

      authMethods.signUpWithEmailAndPassword(emailTextEditingController.text,
      passwordTextEditingController.text).then((val){
        // print ("{$val.uId}");

       


        dataBaseMethods.uploadUserInfo(userInfoMap);

        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => ChatRoom()
        ));

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isloading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ): SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          validator: (val) {
                            return val.isEmpty || val.length < 1
                                ? "please enter a username"
                                : null;
                          },
                          controller: userNameTextEditingController,
                          style: simpleTextStyle(),
                          decoration:
                              textFieldInputDecoration("enter username")),
                      TextFormField(
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val)
                                ? null
                                : "Enter a valid email";
                          },
                          controller: emailTextEditingController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("enter email")),
                      TextFormField(
                        obscureText: true,
                          validator: (val) {
                            return val.length > 6
                                ? null
                                : "please  enter password higher than 6 digits ";
                          },
                          controller: passwordTextEditingController,
                          style: simpleTextStyle(),
                          decoration:
                              textFieldInputDecoration("enter password")),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        "forgot password",
                        style: simpleTextStyle(),
                      ),
                    )),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    signMeUp();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0xff007EF4),
                          const Color(0xff2A75BC),
                        ]),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text("Sign Up", style: mediumTextStyle()),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Sign Up with Google",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Already have an account?", style: mediumTextStyle()),
                  GestureDetector(
                    onTap: (){
                      widget.toggle(); 
                    },
                                      child: Container(
                      padding: EdgeInsets.symmetric(vertical:8),
                      child: Text("Signin Here",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          )),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
