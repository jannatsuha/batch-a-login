import 'package:batch_a_29_dec/helper/menu_widget.dart';
import 'package:batch_a_29_dec/model/admin_post_model.dart';
import 'package:batch_a_29_dec/screen/log_in.dart';
import 'package:batch_a_29_dec/screen/student_details.dart';
import 'package:batch_a_29_dec/screen/user_profile.dart';
import 'package:batch_a_29_dec/utills/all_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
AllColor allColors= AllColor();

GlobalKey<SliderMenuContainerState> _key =
new GlobalKey<SliderMenuContainerState>();
List<AdminPostModel> st=[];
AdminPostModel adminPostModel= AdminPostModel();
class _HomePageState extends State<HomePage> {
  final _fireStore = FirebaseFirestore.instance;
  Future<void> getData() async {
    QuerySnapshot querySnapshot = await
    _fireStore.collection('adminText').get();
    final allData = querySnapshot.
    docs.map((doc) => doc.data()).toList();
    //for a specific field
    //final allData = querySnapshot.docs.map((doc) => doc.get('fieldName')).toList();
    //adminPostModel=AdminPostModel.fromMap(allData[0]);
    for(int i=0; i<allData.length;i++)
      st.add(AdminPostModel.fromMap(allData[i]));
    // print(allData[0]);
    // print("1111111111");
  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:
      SliderMenuContainer(
        appBarColor: allColors.appcontColor,
        key: _key,
        sliderMenuCloseSize: 0,
        title: Text(
          "HOME",
          style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.055,
              fontWeight: FontWeight.w800),
        ),
        shadowColor: Colors.transparent,
        drawerIconColor: Colors.white,
        drawerIconSize: width * 0.08,
        //slideDirection: Slider.RIGHT_TO_LEFT,
        //appBarPadding: const EdgeInsets.only(top: 10),
        sliderMenuOpenSize: 280,
        appBarHeight: 100,
        appBarPadding: EdgeInsets.fromLTRB(0, 40, 0, 0),
        sliderMenu: MenuWidget(
          //  onProfilePictureClick: () {},
          onItemClick: (title) {
            _key.currentState!.closeDrawer();
            setState(() {
              title = title;
              if (title == "HOME") {

              } else if (title == "MY PROFILE") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:
                      (context) => UserProfile()),
                );
              } else if (title == "STUDENT DETAILS") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:
                      (context) => StudentDetails()),
                );

              }
              else if (title == "SHARE APP") {


              }
              else if (title == "LOG OUT") {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement
                  (context, MaterialPageRoute
                  (builder: (context)=>LogIn()));
              }
            });
          },
        ),
        // ekhan theke home page er design suru
        sliderMain: Container(
          color: Colors.white,
          child:
              st.length<=0?
               Container(
                 width: MediaQuery.of(context).size.width,
                   child: Padding(
                     padding: const EdgeInsets.all(148.0),
                     child: CircularProgressIndicator(
                       color: Colors.teal,
                     ),
                   ))
          :SingleChildScrollView(
            child: Column(
              children: [

                for(int j=st.length-1;j>=0;j--)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.teal
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage
                                    ('assets/avatar.png',),
                                  radius: 30,
                                  backgroundColor: Colors.grey,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Admin",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20
                                        ),),
                                      Text(st[j].time.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16
                                        ),),
                                    ],
                                  ),
                                )
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(
                                st[j].post.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 22
                                ),
                                //adminPostModel.post.toString()
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
