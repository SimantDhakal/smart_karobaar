import 'package:flutter/material.dart';
import 'package:law_dairy/resources/AppColor.dart';
import 'package:law_dairy/screen/module/training_screen.dart';

class SideBarMenu extends StatefulWidget {
  @override
  _SideBarMenuState createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[

                ///  profile setting section
                Container(
                  color: AppColor.themeBg,
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, bottom: 0.0),
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text("Smart Karobaar",
                                style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                  child: Column(
                    children: <Widget>[
                      /// profile section
                      SizedBox(
                        height: 30.0,
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Menu', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),

                      SizedBox(
                        height: 15.0,
                      ),

                      // edit profile segment
                      InkWell(
                        onTap: () {
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90.0),
                                color: Colors.teal,
                              ),
                              child: Icon(Icons.assignment, color: Colors.white, size: 20.0),
                            ),

                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Subscription', style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54, size: 20.0),
                            ),
                          ],
                        ),
                      ),

                      ///  Regional
                      SizedBox(
                        height: 20.0,
                      ),

                      // edit profile segment
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingScreen()));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90.0),
                                color: Colors.green,
                              ),
                              child: Icon(Icons.supervised_user_circle_outlined, color: Colors.white, size: 20.0),
                            ),

                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Training', style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54, size: 20.0),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

                      // account segment
                      InkWell(
                        onTap: () {
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90.0),
                                color: Colors.lightBlue,
                              ),
                              child: Icon(Icons.lock_outline, color: Colors.white, size: 20.0),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Update Profile', style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54, size: 20.0),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

                      InkWell(
                        onTap: () {
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90.0),
                                color: Colors.red,
                              ),
                              child: Icon(Icons.logout, color: Colors.white, size: 20.0,),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Logout', style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 30.0,
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Support', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        padding: EdgeInsets.only(left: 10.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () async {
                                // const url = "tel:9779851300235";
                                // if (await canLaunch(url)) {
                                //   await launch(url);
                                // } else {
                                //   throw 'Could not launch $url';
                                // }
                              },
                              child: Image.asset("assets/icons/phone.png", height: 28.0),
                            ),
                            SizedBox(width: 20.0),
                            InkWell(
                              onTap: () async {
                                // const url = "viber://chat?number=+9779851300235";
                                // if (await canLaunch(url)) {
                                //   await launch(url);
                                // } else {
                                //   throw "Could not launch $url";
                                // }
                              },
                              child: Image.asset("assets/icons/viber.png", height: 28.0),
                            ),
                            SizedBox(width: 20.0),
                            InkWell(
                              onTap: () async {
                                // const url = "https://api.whatsapp.com/send?phone=+9779851300235";
                                // if (await canLaunch(url)) {
                                //   await launch(url);
                                // } else {
                                //   throw "Could not launch $url";
                                // }
                              },
                              child: Image.asset("assets/icons/whatsapp.png", height: 28.0),
                            ),
                            SizedBox(width: 20.0),
                            InkWell(
                              onTap: () async {
                                // const url = "https://www.facebook.com/www.reco.com.np";
                                // if (await canLaunch(url)) {
                                //   await launch(url);
                                // } else {
                                //   throw "Could not launch $url";
                                // }
                              },
                              child: Image.asset("assets/icons/facebook.png", height: 28.0),
                            ),
                            SizedBox(width: 20.0),
                            InkWell(
                              onTap: () async {
                                // const url = "mailto:support@reco.com.np";
                                // if (await canLaunch(url)) {
                                //   await launch(url);
                                // } else {
                                //   throw 'Could not launch $url';
                                // }
                              },
                              child: Image.asset("assets/icons/email.png", height: 28.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),

                Text("App Version: 1.0.0", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black54)),

              ],
            ),
          )
        ],
      ),
    );
  }
}