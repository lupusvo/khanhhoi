import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sea_demo01/generated/l10n.dart';
import 'package:sea_demo01/src/blocs/Login/auth_bloc.dart';
import 'package:sea_demo01/src/controller/login_controller.dart';
import 'package:sea_demo01/src/ui/compoment/compoment.dart';
import 'package:sea_demo01/src/ui/screen.dart';
import 'package:sea_demo01/src/ui/themes/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final LoginController controller = Get.put(LoginController());
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  bool _isLoading = false;
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

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
                                        enabled: !controller.loginProcess.value,
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
                                        enabled: !controller.loginProcess.value,
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
                                      onPressed: () async {
                                        String error = await controller.login(UserName: _userController.text,
                                         PassWord: _passController.text, 
                                         Type: 3,
                                        );
                                        if (error != "") {
                                          Get.defaultDialog(
                                              title: "Oop!", middleText: error);
                                        } else {
                                          final prefs = await SharedPreferences.getInstance();
                                          String token = prefs.getString("token").toString();
                                          if( token == "Unknown Error"){
                                            Fluttertoast.showToast(
                                              msg: "Tài khoản hoặc mật khẩu không đúng.\n Vui lòng nhập lại!",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: const Color.fromRGBO(70, 70, 70, 1.0),
                                              textColor: Colors.white,
                                              fontSize: 12.0);
                                          }else{
                                            SmartDialog.showLoading(
                                              backDismiss: false,
                                              msg: 'Đang tải',
                                            );
                                            await Future.delayed(const Duration(seconds: 2));
                                            SmartDialog.dismiss();
                                            Get.to(const ScreenMain());
                                          }
                                        }
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
}
