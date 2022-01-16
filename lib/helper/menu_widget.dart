import 'package:batch_a_29_dec/utills/all_color.dart';
import 'package:flutter/material.dart';

AllColor allColors=AllColor();
class MenuWidget extends StatelessWidget {
  final Function(String) onItemClick;

  const MenuWidget({Key? key, required this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double _heightOnly=MediaQuery.of(context).size.height;
    double _widthOnly=MediaQuery.of(context).size.width;
    return Container(
      color: allColors.appColor,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: _heightOnly*0.045,
          ),
          CircleAvatar(
            backgroundColor:
            allColors.apptext,
            radius: 100,
            backgroundImage: AssetImage
              ('assets/avatar.png',),
          ),
          SizedBox(
            height: 10,
          ),
          // Text(
          //   'Creator',
          //   style: TextStyle(
          //     color: Colors.teal,
          //     fontWeight: FontWeight.bold,
          //     fontSize: _widthOnly*0.04,
          //     fontFamily: 'BalsamiqSans',),
          // ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: allColors.detailTextColor,
                fontWeight: FontWeight.bold,
                fontSize: _widthOnly*0.06,
                fontFamily: 'BalsamiqSans',),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          sliderItem('HOME', Icons.home),
          sliderItem("MY PROFILE", Icons.account_circle_sharp),
          sliderItem('STUDENT DETAILS', Icons.list_alt_outlined),
          sliderItem('SHARE APP', Icons.share),
          sliderItem('LOG OUT', Icons.logout)
        ],
      ),
    );
  }

  Widget sliderItem(String title, IconData icons) => ListTile(
      title: Text(
        title,
        style:
        TextStyle(color: allColors.apptext
            , fontSize: 20),
      ),
      leading: Icon(
        icons,
        size: 30,
        color: allColors.apptext,
      ),
      onTap: () {
        onItemClick(title);
      });
}