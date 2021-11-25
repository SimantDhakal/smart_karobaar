import 'package:flutter/material.dart';
import 'package:law_dairy/resources/AppColor.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrainingScreen extends StatefulWidget {
  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {

  bool freeLink, paidLink;
  String videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=Z_mlOXnOiHg");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      freeLink = false;
      paidLink = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return Scaffold(
      backgroundColor: AppColor.darkModeBg,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        title: Text('Training'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/pattern1.png", height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
          ),
          SingleChildScrollView(
            child: Positioned(
              top: 0, left: 0, right: 0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    bannerWidget(),
                    SizedBox(height: 20.0),
                    YoutubePlayer(
                      controller: _controller,
                      liveUIColor: Colors.amber,
                    ),

                    Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        Card(
                          color: Color.fromRGBO(51, 55, 62, 1),
                          elevation: 2,
                          child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(padding: EdgeInsets.only(left: 15.0),
                                            child: Text("Free Training", style: TextStyle(color: Colors.grey[300], fontSize: 16.0, fontWeight: FontWeight.w400))),
                                        IconButton(onPressed: () {
                                          setState(() {
                                            if (freeLink == false) {
                                              freeLink = true;
                                            } else {
                                              freeLink = false;
                                            }
                                          });
                                        },
                                            icon: Icon(freeLink ? Icons.keyboard_arrow_up_sharp : Icons.keyboard_arrow_down_sharp, color: Colors.grey[300])),
                                      ],
                                    ),
                                  ),

                                  if (freeLink == true)
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 7.0),
                                                child: Text('⦿ This code is designed to be used to type any symbol that does not have a dedicated key on the keyboard.',
                                                    style: TextStyle(color: Colors.grey[400])),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 7.0),
                                                child: Text('⦿ Type any symbol that does not have a dedicated key on the keyboard.',
                                                    style: TextStyle(color: Colors.grey[400])),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 7.0),
                                                child: Text('⦿ Designed to be used to type any symbol that does not have a dedicated key on the keyboard.',
                                                    style: TextStyle(color: Colors.grey[400])),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 7.0),
                                                child: Text('⦿ Symbol that does not have a dedicated key on the keyboard.',
                                                    style: TextStyle(color: Colors.grey[400])),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 10.0, left: 12.0, right: 12.0),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(child: RaisedButton(onPressed: () {},
                                                  color: Colors.blue,
                                                  child: Text("Open Link", style: TextStyle(color: Colors.grey[300])))),
                                              SizedBox(width: 20.0),
                                              Expanded(child: RaisedButton(onPressed: () {},
                                                  color: Colors.indigo,
                                                  child: Text("Share Link", style: TextStyle(color: Colors.grey[300])))),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              )
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Card(
                          color: Color.fromRGBO(51, 55, 62, 1),
                          elevation: 2,
                          child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(padding: EdgeInsets.only(left: 15.0),
                                            child: Text("Paid Training", style: TextStyle(color: Colors.grey[300], fontSize: 16.0, fontWeight: FontWeight.w400))),
                                        IconButton(onPressed: () {
                                          setState(() {
                                            if (paidLink == false) {
                                              paidLink = true;
                                            } else {
                                              paidLink = false;
                                            }
                                          });
                                        },
                                            icon: Icon(paidLink ? Icons.keyboard_arrow_up_sharp : Icons.keyboard_arrow_down_sharp, color: Colors.grey[300])),
                                      ],
                                    ),
                                  ),

                                  if (paidLink == true)
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 7.0),
                                                child: Text('⦿ This code is designed to be used to type any symbol that does not have a dedicated key on the keyboard.',
                                                    style: TextStyle(color: Colors.grey[400])),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 7.0),
                                                child: Text('⦿ Type any symbol that does not have a dedicated key on the keyboard.',
                                                    style: TextStyle(color: Colors.grey[400])),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 7.0),
                                                child: Text('⦿ Designed to be used to type any symbol that does not have a dedicated key on the keyboard.',
                                                    style: TextStyle(color: Colors.grey[400])),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 7.0),
                                                child: Text('⦿ Symbol that does not have a dedicated key on the keyboard.',
                                                    style: TextStyle(color: Colors.grey[400])),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 10.0, left: 12.0, right: 12.0),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(child: RaisedButton(onPressed: () {},
                                                  color: Colors.blue,
                                                  child: Text("Open Link", style: TextStyle(color: Colors.grey[300])))),
                                              SizedBox(width: 20.0),
                                              Expanded(child: RaisedButton(onPressed: () {},
                                                  color: Colors.indigo,
                                                  child: Text("Share Link", style: TextStyle(color: Colors.grey[300])))),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              )
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bannerWidget() {
    return Card(
      child: Container(
        child: Image.network("https://blog.daraz.lk/wp-content/uploads/2020/06/DARAZ-GAMES-BANNER-1.jpg"),
      ),
    );
  }
}
