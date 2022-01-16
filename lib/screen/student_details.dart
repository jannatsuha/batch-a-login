import 'package:batch_a_29_dec/model/user_model.dart';
import 'package:batch_a_29_dec/screen/all_student_profile.dart';
import 'package:batch_a_29_dec/screen/sign_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class StudentDetails extends StatefulWidget {
  const StudentDetails({Key? key}) : super(key: key);

  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}


class _StudentDetailsState extends State<StudentDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: allColor.appColor,
        title: Text("Student Details"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: deptList.length,
                  itemBuilder:(context,index){
                    return Padding(
                      padding: const EdgeInsets.only(left: 40.0,
                      right: 40, top: 10, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: allColor.appColor
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){

                              Navigator.push(context,
                              MaterialPageRoute(builder:
                              (context)=>AllStudentProfile
                                (deptName: deptList[index])));
                            },
                            child: Row(
                              children: [
                                Text(deptList[index],
                                style: TextStyle(
                                  color: allColor.apptext,
                                  fontSize: 25
                                ),),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios,
                                size: 32, color: allColor.apptext,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
