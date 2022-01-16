import 'dart:io';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:batch_a_29_dec/model/user_model.dart';
import 'package:batch_a_29_dec/screen/log_in.dart';
import 'package:batch_a_29_dec/screen/zoom_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}
String? url;
File? image;
User? user= FirebaseAuth.instance.currentUser;

class _UserProfileState extends State<UserProfile> {
  //User _user= FirebaseAuth.instance.
  Future getImageFromStorage() async{
    final ref= FirebaseStorage.instance.ref()
        .child(user!.uid.toString());
    url= await ref.getDownloadURL();
    setState(() {
      url;
    });
  }
  UserModel userModel= UserModel();
  @override
  void initState() {
    super.initState();
    getImageFromStorage();
    FirebaseFirestore.instance
    .collection("users")
    .doc("App Development")
        .collection('allStd')
    .doc(user!.uid)
    .get()
    .then((value){
      this.userModel= UserModel.fromMap(value.data());
      setState(() {

      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: allColor.appColor,
        title: Text("User Profile"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150,
                width: 150,
                child: ClipOval(
                  child: url==null? Text("Image not found"):
                  Image.network(url!,fit: BoxFit.cover,),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: allColor.appColor
                ),
                  onPressed: () async{
                  final image2= await ImagePicker().pickImage(
                      source: ImageSource.gallery);
                  if(image2==null) return;
                  final tempImage= File(image2.path);
                  setState(() {
                    image= tempImage;
                  });
                  saveImage();
                  getImageFromStorage();
                  setState(() {
                    url;
                  });
              },
                  child: Text("Change Picture")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: allColor.appColor
                  ),
                  onPressed: (){
                    getImageFromStorage();
                  },
                  child: Text("Refresh")),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("Name: ${userModel.name.toString()}",
                   style: TextStyle(
                       fontSize: 18
                   ),),
                 Text("Student Id: ${userModel.id.toString()}",
                   style: TextStyle(
                       fontSize: 18
                   ),),

                 Text("Age: ${userModel.age.toString()}",
                   style: TextStyle(
                       fontSize: 18
                   ),),
                 Text("Phone: ${userModel.phone.toString()}",
                   style: TextStyle(
                       fontSize: 18
                   ),),
                 Text("Email: ${userModel.email.toString()}",
                   style: TextStyle(
                       fontSize: 18
                   ),),
                 Text("Dept: ${userModel.dept.toString()}",
                   style: TextStyle(
                       fontSize: 18
                   ),),
                 Text("Blood Group: ${userModel.bloodGroup.toString()}",
                   style: TextStyle(
                       fontSize: 18
                   ),),

               ],
             )

            ],
          ),
        ),
      ),
    );
  }
  void saveImage()async{
    if(image==null) return;
    final destination= 'image/id1';
    final ref= FirebaseStorage.instance
        .ref(destination);
    ref.putFile(image!);
  }
}
