import 'dart:async';
import 'dart:io';

import 'package:batch_a_29_dec/helper/custom_text_field.dart';
import 'package:batch_a_29_dec/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
class AllStudentProfile extends StatefulWidget {
  String deptName;
   AllStudentProfile({Key? key,
     required this.deptName
   }) : super(key: key);

  @override
  _AllStudentProfileState createState() => _AllStudentProfileState();
}
int count=0;
Timer? timer;
int counter = 0;
List<String> imgList=[];
String? _url;
String? tempUrl;
File? _image;
User? _user= FirebaseAuth.instance.currentUser;
class _AllStudentProfileState extends State<AllStudentProfile> {

  Future getImageFromStorage(uid) async{
    final ref= FirebaseStorage.instance.ref()
        .child(uid.toString());
    _url= await ref.getDownloadURL();
    return _url;
    setState(() {
      _url;
    });
  }


  List<UserModel> userModelList=[];
  final _fireStore = FirebaseFirestore.instance;
  Future<void> getStudentData() async {
    QuerySnapshot querySnapshot = await
    _fireStore.collection('users')
        .doc(widget.deptName)
        .collection('allStd')
        .get();
    final allData = querySnapshot.
    docs.map((doc) => doc.data()).toList();
    //for a specific field
    //final allData = querySnapshot.docs.map((doc) => doc.get('fieldName')).toList();
    //adminPostModel=AdminPostModel.fromMap(allData[0]);
    if(allData!= null)
    for(int i=0; i<allData.length;i++)
      userModelList.add(UserModel.fromMap(allData[i]));
    // print(allData[0]);
    // print("1111111111");
    //print(userModelList[0].name);
  }
  void addImage() async{
    if(userModelList.length>0)
      for(int i=0; i<userModelList.length;i++)
      {
        final url= await getImageFromStorage(userModelList[i].uid);
        imgList.add(url.toString());
        print("tttttttttt");
        print(url.toString());
      }
  }

  @override
  void initState() {
    timer = Timer.periodic(
        Duration(seconds: 5),
            (Timer t) {
          count++;
          if(count==2)
            timer!.cancel();
          setState(() {

          });
          addImage();
            });
    getStudentData();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: allColor.appColor,
        title: Text("abc"),
      ),
      body:
          userModelList.length<1?
              Container(
                child: Center(
                    child: Text("No data found")),
              )
      :ListView.builder(
        itemCount:userModelList.length ,
          itemBuilder: (context, index){

            return Center(
              child:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0,
                    bottom: 8,left: 30,right: 30),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                         backgroundColor: Colors.teal,
                          backgroundImage: NetworkImage(
                            imgList[index]
                          ) ,
                        ),

                        ListTile(
                          minVerticalPadding: 0,
                         // tileColor: Colors.grey,
                            horizontalTitleGap: 1,
                            contentPadding: EdgeInsets.all(2),
                          title: Text("Name :",
                          style: TextStyle(fontSize: 15,
                              color: Colors.teal,
                              ),),
                            trailing: Text(userModelList[index]
                                .name.toString(),
                              style: TextStyle(fontSize: 15),)),

                        ListTile(
                            horizontalTitleGap: 1,
                            contentPadding: EdgeInsets.all(2),
                            title: Text("Student ID :",
                              style: TextStyle(fontSize: 15,
                                color: Colors.teal,
                              ),),
                            trailing: Text(userModelList[index]
                                .id.toString(),
                              style: TextStyle(fontSize: 15),)),
                        ListTile(
                            horizontalTitleGap: 1,
                            contentPadding: EdgeInsets.all(2),
                            title: Text("Dept :",
                              style: TextStyle(fontSize: 15,
                                color: Colors.teal,
                              ),),
                            trailing: Text(userModelList[index]
                                .dept.toString(),
                              style: TextStyle(fontSize: 15),)),
                        ListTile(
                            horizontalTitleGap: 1,
                            contentPadding: EdgeInsets.all(2),
                            title: Text("Age :",
                              style: TextStyle(fontSize: 15,
                                color: Colors.teal,
                              ),),
                            trailing: Text(userModelList[index]
                                .age.toString(),
                              style: TextStyle(fontSize: 15),)),

                        ListTile(
                            horizontalTitleGap: 1,
                            contentPadding: EdgeInsets.all(2),
                            title: Text("Phone :",
                              style: TextStyle(fontSize: 15,
                                color: Colors.teal,
                              ),),
                            trailing: Text(userModelList[index]
                                .phone.toString(),
                              style: TextStyle(fontSize: 15),)),
                        ListTile(

                          horizontalTitleGap: 1,
                           contentPadding: EdgeInsets.all(2),
                            title: Text("Email :",
                              style: TextStyle(fontSize: 15,
                                color: Colors.teal,
                              ),),
                            trailing: Text(userModelList[index]
                                .email.toString(),
                              style: TextStyle(fontSize: 15),)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      )
    );
  }
}
