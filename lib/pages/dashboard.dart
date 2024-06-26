import 'package:edu_ai/pages/achiver.dart';
import 'package:edu_ai/pages/profile_page.dart';
import 'package:edu_ai/pages/screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
void logout(){
  FirebaseAuth.instance.signOut();
}
class _HomeScreenState extends State<HomeScreen> {
  int currentIndex =0;

  double screenHeight = 0;

  double screenWeight = 0;

  Color primary = Color(0xFF2b2d42);

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWeight = MediaQuery.of(context).size.width;

    List <IconData> navigationIcon =[
      FontAwesomeIcons.house,
      FontAwesomeIcons.star,
      FontAwesomeIcons.user,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('E D U - A I ',style: TextStyle(color: Colors.white,fontSize: 20),),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: logout,
              icon: Icon(Icons.logout)),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          Screen(),
          Achiver(),
          ProfileScreen(),

        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 24,
        ),
        height: 70,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(2, 2),
              )
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i = 0; i < navigationIcon.length; i++)...<Expanded>{
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        currentIndex = i;
                      });
                    },
                    child: Container(
                      height: screenHeight,
                      width: screenWeight,
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(navigationIcon[i],
                                color: i == currentIndex ? primary: Colors.black54,
                                size: i == currentIndex? 30 : 25),
                            i == currentIndex ?   Container(
                              margin: EdgeInsets.only(top: 6),
                              height: 3,
                              width: 22,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                color: primary,
                              ),

                            ):SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}