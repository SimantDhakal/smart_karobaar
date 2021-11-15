import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:law_dairy/components/rounded_btn/rounded_btn.dart';
import 'package:law_dairy/resources/api/route_manager.dart';
import 'package:law_dairy/resources/api/view_storage.dart';
import 'package:law_dairy/screen/module/dashboard_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _emailController = new TextEditingController(text: "simant.dhakal@gmail.com");
  TextEditingController _passwordController = new TextEditingController(text: "password");

  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 150.0),
                Image.asset("assets/images/shreicon.png", width: 120.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 8),
                  child: Text('Login to Smart Market',
                    style: TextStyle(
                        color: Color(0xff251F34),
                        fontWeight: FontWeight.w600,
                        fontSize: 20
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Please sign in to continue.',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'E-mail',
                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Color(0xff251F34)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _emailController,
                          style: (TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400
                          )),
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.white,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.grey[200],
                            filled: true,
                            prefixIcon: Icon(Icons.email_outlined, color: Color(0xff251F34),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Password',
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Color(0xff251F34)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _passwordController,
                        style: (TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w400
                        )),
                        obscureText: true,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Icon(Icons.lock_outline, color: Color(0xff251F34)),
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: RoundedButton(
                      btnText: 'LOGIN',
                      color: Color(0xff14DAE2),
                      onPressed: () async {
                        // Add login code
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          // _login();
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (BuildContext context) => DashboardScreen()),
                                  (route) => false);
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // login
  Future<void> _login() async {

    var dio = await Dio();
    final urlLogin = Interface.base_url+Interface.login;
    var formData = FormData.fromMap({
      "email": _emailController.text.toString(),
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
    ViewStorage.logInfo.add(responseData);
    print(ViewStorage.logInfo[0].toString());

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
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) => DashboardScreen()),
              (route) => false);
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