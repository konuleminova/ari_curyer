import 'package:ari_kuryer/services/api_helper/api_response.dart';
import 'package:ari_kuryer/ui/common_widgets/error_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ari_kuryer/utils/size_config.dart';

class LoginView extends StatelessWidget {
  ApiResponse apiResponse;
  Function loginCallback;
  TextEditingController loginController, passController;

  LoginView(
      {this.apiResponse,
      this.loginCallback,
      this.passController,
      this.loginController});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      height: SizeConfig().screenHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/logo.png',
            width: 160.toWidth,
            height: 80.toHeight,
          ),
          SizedBox(height: 44.toHeight,),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: 60.toWidth, vertical: 16.toHeight),
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: loginController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 4.toWidth),
                        hintText: 'Login',
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 8.toHeight,
                ),
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: passController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 4.toWidth),
                        hintText: 'Password',
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 24.toHeight,
                ),
                InkWell(
                  child: Container(
                    // height: 50.toHeight,
                    color: Colors.black,
                    child: TextField(
                      textAlign: TextAlign.center,
                      enabled: false,
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.only(left: 8.toWidth),
                          hintText: 'LOGIN',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none),
                    ),
                  ),
                  onTap: () {
                    loginCallback();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
