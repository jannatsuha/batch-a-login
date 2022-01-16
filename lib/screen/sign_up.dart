import 'dart:io';
//import 'package:path_provider/path_provider.dart';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:batch_a_29_dec/helper/custom_button.dart';
import 'package:batch_a_29_dec/helper/custom_text_field.dart';
import 'package:batch_a_29_dec/model/user_model.dart';
import 'package:batch_a_29_dec/screen/log_in.dart';
import 'package:batch_a_29_dec/screen/verify_email.dart';
import 'package:batch_a_29_dec/utills/all_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

List<String> deptList=[
  "App Development",
  "Graphics Design",
  "RAC",
  "Electrics",
  "Electrical",
  "Driving",
  "Welding",
  "Garments"
];
List<String>bloodGroupList=[
  "A+",
  "A-",
  "B+",
  "B-",
  "AB+",
  "AB-",
  "O+",
  "O-"
];

String ? initValDept;
String ? initValBloodGroup;
final _auth= FirebaseAuth.instance;
AllColor allColor= AllColor();
TextEditingController _emailController=TextEditingController();
TextEditingController _idController=TextEditingController();
TextEditingController _passController=TextEditingController();
TextEditingController _confirmPassController=TextEditingController();
TextEditingController _ageController=TextEditingController();
TextEditingController _phoneController=TextEditingController();
TextEditingController _nameController=TextEditingController();
File? image;
class _SignUpState extends State<SignUp> {
 final _formKeySignUp= GlobalKey<FormState>();
 Future pickImageFromGallery( source) async{
   final image2= await ImagePicker().pickImage(
       source: source);
   if(image2==null) return;
   final tempImage= File(image2.path);
   setState(() {
     image= tempImage;
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKeySignUp,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: (){
                  alert(
                    context,
                  //  title: Text('Alert'),
                    content: Text('Select One'),
                    textOK: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: (){
                                pickImageFromGallery(ImageSource.camera);
                                Navigator.of(context).pop();
                                },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Take from Camera',
                                style: TextStyle(
                                  fontSize: 20
                                ),
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap:(){
                              pickImageFromGallery(ImageSource.gallery);
                              Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Take from Gallery',
                                  style: TextStyle(
                                      fontSize: 20
                                  ),),
                              )),
                        ],
                      ),
                    ),
                  );
                },
                child: ClipOval(
                  child:
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.deepOrange
                          ),
                          borderRadius: BorderRadius.circular(180)
                        ),
                        height: 130,
                          width: 130,
                          child: image!= null?
                          Image.file(image!,
                            fit: BoxFit.cover,):
                          Icon(Icons.camera_alt,
                            size: 40,),
                      ),

                ),
              ),

              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "Enter your full-name",
                labelText: "Full-Name",
                controller: _nameController ,
                obsecureVal: false,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "Enter Student ID",
                labelText: "Student ID",
                controller: _idController ,
                obsecureVal: false,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "Enter your phone number",
                labelText: "Phone Number",
                controller: _phoneController ,
                obsecureVal: false,
              ),
              SizedBox(
                height: 20,
                child: Divider(

                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 55,
                    width: 153,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0,
                          right: 0,bottom: 8,top: 8),
                      child: DropdownButton(
                        iconDisabledColor: Colors.deepOrange,
                        iconEnabledColor: Colors.deepOrange,
                        hint: Text("Department",
                          style: TextStyle(color: Colors.deepOrange,),),
                        items: deptList.map(
                                (val) => DropdownMenuItem(
                                value: val,
                                child: Text(val,
                                  style: TextStyle(color: Colors.deepOrange),
                                )
                            )
                        ).toList(),

                        onChanged: (newVal){
                          setState(() {
                            initValDept=newVal.toString();
                          });
                        },
                        value: initValDept,
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    width: 153,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey
                      ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0,
                          right: 0,bottom: 8,top: 8),
                      child: DropdownButton(
                        iconDisabledColor: Colors.deepOrange,
                        iconEnabledColor: Colors.deepOrange,
                        hint: Text("Blood Group",
                          style: TextStyle(color: Colors.deepOrange),),
                        items: bloodGroupList.map(
                                (val) => DropdownMenuItem(
                                value: val,
                                child: Text(val,
                                    style: TextStyle(color: Colors.deepOrange),
                                )
                            )
                        ).toList(),

                        onChanged: (newVal){
                          setState(() {
                            initValBloodGroup=newVal.toString();
                          });
                        },
                        value: initValBloodGroup,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
                child: Divider(

                ),
              ),
              CustomTextField(
                hintText: "Enter your Age",
                labelText: "Age",
                controller: _ageController ,
                obsecureVal: false,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "Enter your email",
                labelText: "Email",
                controller: _emailController ,
                obsecureVal: false,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                hintText: "Enter new password",
                labelText: "Password",
                controller: _passController ,
                obsecureVal: true,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                hintText: "Re-enter your password",
                labelText: "Confirm Password",
                controller: _confirmPassController ,
                obsecureVal: true,
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: (){
                 signUp(_emailController.text,
                     _passController.text,
                     context,_formKeySignUp
                 );
                 },
                child: CustomButton(
                  height: 60,
                  width: 300,
                  btnText: "Sign Up",
                ),
              ),
              SizedBox(
                height: 15,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
void signUp(String email, String password,
    context,_formKeySignUp)async{
  if(_formKeySignUp.currentState!.validate() && image!=null){
    await _auth.createUserWithEmailAndPassword
      (email: email, password: password)
        .then((value) => {
          saveUserDetails(),
          saveImage(),
          Fluttertoast.showToast(msg: "SignUp Successful!"),
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context)=>VerifyEmailPage(
                email: _emailController.text
              )))
    }).catchError((e){
      Fluttertoast.showToast(msg:e.message);

    });
  }else{
    Fluttertoast.showToast(msg: "Image can not be null");
  }

}
//  toFile ()async{
//   var bytes = await rootBundle.load('assets\images\profile.png');
//   String tempPath = (await getTemporaryDirectory()).path;
//   File file = File('$tempPath/profile.png');
//   await file.writeAsBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
//
//   return file;
// }
void saveImage()async{
  User? _user= FirebaseAuth.instance.currentUser;
  if(image==null)
    return;
  final destination= _user!.uid.toString();
  final ref= FirebaseStorage.instance
      .ref(destination);
  ref.putFile(image!);
}
void saveUserDetails() async{
  FirebaseFirestore firestore123=
      FirebaseFirestore.instance;
  User? user= _auth.currentUser;
  
  UserModel userModel=UserModel();
  userModel.uid=user!.uid;
  userModel.email= _emailController.text;
  userModel.id= _idController.text;
  userModel.phone= _phoneController.text;
  userModel.age= _ageController.text;
  userModel.name= _nameController.text;
  userModel.dept= initValDept;
  userModel.bloodGroup= initValBloodGroup;

  await firestore123.collection("users").
  doc(initValDept)
  .collection('allStd')
  .doc(user.uid)
  .set(userModel.toMap());
  Fluttertoast.showToast(msg: "Data Saved Successfully");
}