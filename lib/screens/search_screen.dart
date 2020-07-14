import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gist_me/services/database.dart';
import 'package:gist_me/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  
  TextEditingController searchEditingController  = new TextEditingController();

  QuerySnapshot searchSnapshot;
  initiateSearch(){
    dataBaseMethods
    .getUserByUsername(searchEditingController.text)
    .then((val){
      setState(() {
        searchSnapshot= val;
      });
      // print(val.toString());
  });
  }

  // startConversation(String userName){
  //   List<String> users = [userName, myName];
  //   dataBaseMethods.createChatRoom()
  // }

  Widget searchList(){
    return searchSnapshot !=null ? ListView.builder(
      itemCount: searchSnapshot.documents.length,
      shrinkWrap: true,
      itemBuilder: (context, index){
        return SearchTile(

          userName: searchSnapshot.documents[index].data["name"],
          userEmail: searchSnapshot.documents[index].data["email"],
        );
      }): Container();
  }
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child:Column(
          children:[
            Container(
              color: Colors.greenAccent,
              padding: EdgeInsets.symmetric(horizontal:24, vertical:16),
              child: Row(
                children:[
                  Expanded(
                    child: TextField(
                      controller: searchEditingController,
                      decoration: InputDecoration(
                        hintText: "Search a friend...",
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        border: InputBorder.none
                      ),
                    )),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                                      child: Container(
                      height:40,
                      width: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff007EF4),
                          const Color(0xff2A75BC),
                          ]
                        ),
                        borderRadius: BorderRadius.circular(40)
                      ),
                     
                      child: Icon(Icons.search)),
                  ),

                ]
              ),
            ),
              searchList()
            ],
          
        ),
        
      ),
      
    );
  }
}

class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;

  SearchTile ({this.userName, this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(userName, style: mediumTextStyle() ,),
              Text(userEmail, style: mediumTextStyle(),)
            ]
          ),
          Spacer(),
          GestureDetector(
            onTap: (){

            },
                      child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),  
                color:Colors.greenAccent
              ),
              padding: EdgeInsets.symmetric(horizontal:16, vertical:8),
              child: Text("message", style: mediumTextStyle(),)
            ),
          )
        ],
        ),
    );
  }
}