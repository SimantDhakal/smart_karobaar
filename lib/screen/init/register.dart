import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:law_dairy/components/rounded_btn/rounded_btn.dart';
import 'package:law_dairy/resources/AppColor.dart';
import 'package:law_dairy/resources/api/route_manager.dart';
import 'package:law_dairy/screen/init/login.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();

  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: AppColor.darkModeBg,
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset("assets/images/pattern1.png", height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
            ),
            Positioned(
              top: 20.0,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 150.0),
                        Container(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 50.0,
                                width: 50.0,
                                child: CircleAvatar(
                                  backgroundColor: Color.fromRGBO(64, 178, 135, 1),
                                  child: Icon(Icons.lock_outline_rounded, color: Colors.grey[200],),
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 0, 20, 6),
                                      child: Text('Create Account',
                                        style: TextStyle(
                                            color: Colors.grey[300],
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 0, 20, 2),
                                      child: Text('Please sign up to continue.',
                                        style: TextStyle(
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 20.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Phone',
                                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.grey[200]),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 55.0,
                                        child: TextFormField(
                                          controller: _phoneController,
                                          style: TextStyle(
                                              color: Colors.grey[200],
                                              fontWeight: FontWeight.w400
                                          ),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          cursorColor: Colors.white,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(color: Colors.grey[600], width: 1),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(color: Color.fromRGBO(64, 178, 135, 1)),
                                            ),
                                            fillColor: Color.fromRGBO(51, 55, 62, 0.8),
                                            filled: true,
                                            prefixIcon: Icon(Icons.phone, color: Colors.grey[200]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Password',
                                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.grey[300]),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 55.0,
                                      child: TextField(
                                        controller: _passwordController,
                                        style: (TextStyle(
                                            color: Colors.grey[200],
                                            fontWeight: FontWeight.w400
                                        )),
                                        obscureText: true,
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: BorderSide(color: Colors.grey[600], width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: BorderSide(color: Color.fromRGBO(64, 178, 135, 1)),
                                          ),
                                          fillColor: Color.fromRGBO(51, 55, 62, 0.8),
                                          filled: true,
                                          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[200]),
                                        ),
                                        onChanged: (value) {
                                          password = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Confirm Password',
                                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.grey[300]),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 55.0,
                                      child: TextField(
                                        controller: _confirmPasswordController,
                                        style: (TextStyle(
                                            color: Colors.grey[200],
                                            fontWeight: FontWeight.w400
                                        )),
                                        obscureText: true,
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: BorderSide(color: Colors.grey[600], width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: BorderSide(color: Color.fromRGBO(64, 178, 135, 1)),
                                          ),
                                          fillColor: Color.fromRGBO(51, 55, 62, 0.8),
                                          filled: true,
                                          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[200]),
                                        ),
                                        onChanged: (value) {
                                          password = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: RoundedButton(
                                    btnText: 'REGISTER',
                                    color: Color.fromRGBO(64, 178, 135, 1),
                                    onPressed: () {
                                      setState(() {
                                        showSpinner = true;
                                      });
                                      try {

                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Already have an account,", style: TextStyle(color: Colors.grey[200], fontSize: 16.0)),
                              SizedBox(width: 10.0),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                                },
                                child: Text("Sign In", style: TextStyle(color: Color.fromRGBO(64, 178, 135, 1), fontSize: 17.0, fontWeight: FontWeight.normal)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // login
  Future<void> _login() async {

    var dio = await Dio();
    final urlLogin = APIS.base_url+APIS.login;
    var formData = FormData.fromMap({
      "email": _phoneController.text.toString(),
      "password": _passwordController.text.toString()
    });
    final response = await dio.post(urlLogin,
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
      data: formData,
    );


    final responseData = response.data;

    log(responseData.toString());
    if (response.statusCode == 200) {
      setState(() {showSpinner = false;});
      Fluttertoast.showToast(
          msg: "Login success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {

      setState(() {
        showSpinner = false;
      });

      Fluttertoast.showToast(
          msg: responseData['message'].toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }

}