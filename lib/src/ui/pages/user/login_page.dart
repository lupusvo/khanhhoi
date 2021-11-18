import 'dart:convert';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sea_demo01/generated/l10n.dart';
import 'package:sea_demo01/src/blocs/Login/auth_bloc.dart';
import 'package:sea_demo01/src/repositories/infouser_username.dart';
import 'package:sea_demo01/src/ui/compoment/compoment.dart';
import 'package:sea_demo01/src/ui/screen.dart';
import 'package:sea_demo01/src/ui/themes/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = new LoginBloc();
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  bool _isLoading = false;
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();
  InfoUserByUserName _infoUserByUserName = new InfoUserByUserName();

  void checkReloadLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _username = prefs.getString('user').toString();
    String _password = prefs.getString('pass').toString();

    if (_username != null &&
        _password != null &&
        _username != "" &&
        _password != "") {
      _userController.text = _username;
      _passController.text = _password;
    }
    if (_userController.text == "null" && _userController.text == "null") {
      _userController.text = "";
      _passController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    checkReloadLogin();
    return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: _headerHeight,
                  child: HeaderCompoment(
                      _headerHeight,
                      true,
                      Icons
                          .login_rounded), //let's create a common header widget
                ),
                SafeArea(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      margin: const EdgeInsets.fromLTRB(
                          20, 10, 20, 10), // This will be the login form
                      child: Column(
                        children: [
                          const Text(
                            'Hello',
                            style: TextStyle(
                                fontSize: 60, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Signin into your account',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 30.0),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    child: StreamBuilder(
                                      stream: bloc.userStream,
                                      builder: (context, snapshot) => TextField(
                                        controller: _userController,
                                        decoration: ThemeHelper()
                                            .textInputDecoration(
                                                'User Name',
                                                'Enter your user name',
                                                snapshot.hasError
                                                    ? snapshot.error
                                                    : null),
                                      ),
                                    ),
                                    decoration: ThemeHelper()
                                        .inputBoxDecorationShaddow(),
                                  ),
                                  const SizedBox(height: 30.0),
                                  Container(
                                    child: StreamBuilder(
                                      stream: bloc.passStream,
                                      builder: (context, snapshot) => TextField(
                                        obscureText: true,
                                        controller: _passController,
                                        decoration: ThemeHelper()
                                            .textInputDecoration(
                                                S
                                                    .of(context)
                                                    .authPageInputPassword,
                                                S
                                                    .of(context)
                                                    .authPageValidatorEmptyPassword,
                                                snapshot.hasError
                                                    ? snapshot.error
                                                    : null),
                                      ),
                                    ),
                                    decoration: ThemeHelper()
                                        .inputBoxDecorationShaddow(),
                                  ),
                                  const SizedBox(height: 15.0),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 0, 10, 20),
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForgotPasswordPage()),
                                        );
                                      },
                                      child: const Text(
                                        "Forgot your password?",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: ThemeHelper()
                                        .buttonBoxDecoration(context),
                                    child: ElevatedButton(
                                      style: ThemeHelper().buttonStyle(),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            40, 10, 40, 10),
                                        child: Text(
                                          S
                                              .of(context)
                                              .authPageButtonLogin
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      onPressed: () {
                                        //After successful login we will redirect to profile page. Let's create profile page now
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        onSignInClicked(_userController.text,
                                            _passController.text, 3);
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 20),
                                    //child: Text('Don\'t have an account? Create'),
                                    child: Text.rich(TextSpan(children: [
                                      const TextSpan(
                                          text: "Don\'t have an account? "),
                                      TextSpan(
                                        text: 'Create',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const RegistrationPage()));
                                          },
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                    ])),
                                  ),
                                ],
                              )),
                        ],
                      )),
                ),
              ],
            ),
          ),
        );
  }

  Future<void> onSignInClicked(
      String UserName, String PassWord, int Type) async {
    if (bloc.isValidInfo(_userController.text, _passController.text)) {
      var url = Uri.parse('https://i-sea.khanhhoi.net/home/login');
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String ip = await Ipify.ipv4().toString();
      Map<String, String> requestHeaders = {
        'ClientIP': ip,
      };
      Map body = {"UserName_": UserName, "pass_": PassWord, "type_": Type};
      try {
        var res = await http.post(url,
            headers: requestHeaders, body: json.encode(body));
        if (res.statusCode == 200) {
          var jsonResponse = json.decode(res.body);
          if (jsonResponse != null) {
            setState(() {
              _isLoading = false;
            });
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('token', jsonResponse.toString());
            prefs.setString('user', UserName.toString());
            prefs.setString('pass', PassWord.toString());
            await _infoUserByUserName.getInfoUserByUserName();
            SmartDialog.showLoading(
              backDismiss: false,
              msg: 'Đang tải',
            );
            await Future.delayed(Duration(seconds: 2));
            SmartDialog.dismiss();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => ScreenMain()));
          } else {
            Fluttertoast.showToast(
                msg: "Tài khoản hoặc mật khẩu không đúng. Vui lòng nhập lại!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Color.fromRGBO(70, 70, 70, 1.0),
                textColor: Colors.white,
                fontSize: 12.0);
          }
        }
      } catch (e) {
        print(e);
        SmartDialog.showToast("Đường truyền mất kết nối!!!");
      }
    }
  }
}
