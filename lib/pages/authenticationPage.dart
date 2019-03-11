import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:wash_x/constants.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/helpers/formHelper.dart';
import 'package:wash_x/helpers/firebaseHelper.dart';
import 'package:wash_x/helpers/sharedPrefrences.dart';
import 'package:wash_x/models/inputFieldInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wash_x/pages/beforeSetupPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wash_x/pages/mainPage.dart';
import 'package:wash_x/pages/splashScreenPage.dart';
import 'package:wash_x/widgets/helperWidgets.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => new _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage>
    with TickerProviderStateMixin {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _showSignupMessage = false;
  bool _showErrorText = false;
  bool _isForgotPassword = false;

  RemoteConfig remoteConfig;

  // double width;

  FocusNode _focusMain = new FocusNode();

  FocusNode _inputFocusNode = new FocusNode();

  var index = 0;
  Icon extraIcon = new Icon(Icons.vpn_key);
  TextInputType extraKeyboard = TextInputType.text;

  Color colorEmailLabel = Colors.grey;
  Color colorPasswordLabel = Colors.grey;

  FacebookLogin facebookLogin = new FacebookLogin();
  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: <String>['email'],
  );

  @override
  void initState() {
    super.initState();
    setupRemoteConfig();
    _inputFocusNode.addListener(() => _onFocusPassChange());
    _resetInputUI(null);
  }

  void _resetInputUI(List<InputFieldTypes> skipFields) {
    _currentInputIndex = 0;
    FormHelper.init(skipFields);
    _setCurrentFieldInfo(_currentInputIndex);
  }

  void _onFocusPassChange() {
    setState(() {
      if (_inputFocusNode.hasFocus) {
        colorPasswordLabel = Colors.blue;
      } else {
        colorPasswordLabel = Colors.grey;
      }
    });
    debugPrint("Focus: " + _inputFocusNode.hasFocus.toString());
  }

  @override
  void deactivate() {
    _resetInputUI(null);
    super.deactivate();
  }

//State reset --start
  void _resetState() {
    _currentInputController.text = '';
    _showSignupMessage = false;
    _isLoginAttempt = true;
    _showErrorText = false;
    _currentInputErrorText = '';
    _inputFocusNode.unfocus();
    setState(() {});
  }
//State reset --end

//Push DashBoard --start
  void pushHomeScreen(String email) async {
    var _isAcoountSetupCompleate =
        await MySharedPreferences.getSetupCompleteValue();
    Navigator
        .of(context, rootNavigator: true)
        .push(new CupertinoPageRoute<bool>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return _isAcoountSetupCompleate ? MainPage(remoteConfig: remoteConfig,) : BeforeSetupPage();
            }));
  }


  Future<RemoteConfig> setupRemoteConfig() async {
    remoteConfig = await RemoteConfig.instance;
    // Enable developer mode to relax fetch throttling
    remoteConfig.setConfigSettings(new RemoteConfigSettings(debugMode: true));
    remoteConfig.setDefaults(<String, dynamic>{
      'welcome': 'default welcome',
      'hello': 'default hello',
    });

    return remoteConfig;
  }
//Push DashBoard --end

//Firebase Authentications
  GoogleSignInAccount googleUser;
//Google Authentication
  _googleLogin() async {
    _isLoginAttempt = false;
    HelperWidgets.loadingDialog(context);
    googleUser = await _googleSignIn.signIn();
    bool isExists = false;
    isExists = await FirebaseHelper.checkUserByEmail(googleUser.email);

    ///check if user exists by email
    if (isExists) {
      CustomFirebaseUser firebaseUser =
          await FirebaseHelper.loginUserByGoogle(googleUser);
      Navigator.pop(context);
      if (firebaseUser.user != null) {
        _resetState();
        pushHomeScreen(googleUser.email);
      }
    } else {
      try {
        var names = googleUser.displayName.split(' ');
        var email = googleUser.email;
        var firstName = names[0];
        var lastName = names.length > 1 ? names[1] : '';

        List<InputFieldTypes> skipFields = [];
        skipFields.add(InputFieldTypes.USERNAME_EMAIL_PHONE);

        if (email?.isNotEmpty ?? false) {
          skipFields.add(InputFieldTypes.EMAIL);
        }
        if (firstName?.isNotEmpty ?? false) {
          skipFields.add(InputFieldTypes.FIRST_NAME);
        }
        if (lastName?.isNotEmpty ?? false) {
          skipFields.add(InputFieldTypes.LAST_NAME);
        }
        _currentInputErrorText = Constants.compleateSignUpProcess;

        _resetInputUI(skipFields);
        setState(() {});

        FormHelper.setInputFieldValue(InputFieldTypes.LAST_NAME, lastName);
        FormHelper.setInputFieldValue(InputFieldTypes.FIRST_NAME, firstName);
        FormHelper.setInputFieldValue(InputFieldTypes.EMAIL, email);
      } catch (e) {}
      Navigator.of(context).pop();
    }
  }

//Facebook Authentication
  var _profilefb;
  bool isExists = false;
  void _facebookLogin() async {
    HelperWidgets.loadingDialog(context);
    _isLoginAttempt = false;
    var result = await facebookLogin
        .logInWithReadPermissions(['email', 'public_profile']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken.token}');
        _profilefb = json.decode(graphResponse.body);
        isExists = await FirebaseHelper.checkUserByEmail(_profilefb["email"]);
        if (isExists) {
          var firebaseUser = await FirebaseHelper
              .loginUserByFacebook(result.accessToken.token);
          Navigator.of(context).pop();
          if (firebaseUser.user != null) {
            _resetState();

            pushHomeScreen(_profilefb["email"]);
          }
        } else {
          try {
            var email = _profilefb["email"];
            var firstName = _profilefb["first_name"];
            var lastName = _profilefb["last_name"];
            List<InputFieldTypes> skipFields = [];
            skipFields.add(InputFieldTypes.USERNAME_EMAIL_PHONE);

            if (email?.isNotEmpty ?? false) {
              skipFields.add(InputFieldTypes.EMAIL);
            }
            if (firstName?.isNotEmpty ?? false) {
              skipFields.add(InputFieldTypes.FIRST_NAME);
            }
            if (lastName?.isNotEmpty ?? false) {
              skipFields.add(InputFieldTypes.LAST_NAME);
            }
            _currentInputErrorText = Constants.compleateSignUpProcess;
            _resetInputUI(skipFields);
            setState(() {});

            FormHelper.setInputFieldValue(InputFieldTypes.LAST_NAME, lastName);
            FormHelper.setInputFieldValue(
                InputFieldTypes.FIRST_NAME, firstName);
            FormHelper.setInputFieldValue(InputFieldTypes.EMAIL, email);
          } catch (e) {
            // var tt = e;
          }
          Navigator.of(context).pop();
        }

        break;
      case FacebookLoginStatus.cancelledByUser:
        Navigator.pop(context);
        setState(() {
          _currentInputErrorText = Constants.fbLoginCancelled;
          _showErrorText = true;
        });
        break;
      case FacebookLoginStatus.error:
        Navigator.pop(context);
        setState(() {
          _currentInputErrorText = Constants.fbFatalError;
          _showErrorText = true;
        });
        print("error fb");
        break;
    }
  }

  TextEditingController _currentInputController = new TextEditingController();
  InputFieldInfo _currentFieldInfo;
  int _currentInputIndex = 0;
  String _currentInputErrorText = '';
  bool _isLoginAttempt = true;

  void _setCurrentFieldInfo(int index) {
    _currentFieldInfo = FormHelper.getNextInputField(index);
    _currentInputController.text = _currentFieldInfo.value;
  }

  void onInputSubmit(String val) async {
    var value = val.replaceAll(new RegExp(Constants.regexTrimSpaces), "");
    _showSignupMessage = false;

    var error = FormHelper.validateInputField(_currentFieldInfo.type, value);
    if (error.isNotEmpty) {
      setState(() {
        _currentInputErrorText = error;
      });
      return;
    }
    FormHelper.setInputFieldValue(_currentFieldInfo.type, value);

    if (_currentFieldInfo.type == InputFieldTypes.USERNAME_EMAIL_PHONE) {
      var subType = FormHelper.getTypeOfInput(_currentFieldInfo.type, value);
      FormHelper.setInputFieldValue(subType, value);
      var user = FormHelper.getCurrentUser();
      bool isExist = false;
      String email;
      if (user.email != null && user.email.isNotEmpty) {
        HelperWidgets.loadingDialog(context);
        isExist = await FirebaseHelper.checkUserByEmail(user.email);
        email = user.email;
        Navigator.pop(context);
      } else if (user.phoneNumber != null && user.phoneNumber.isNotEmpty) {
        HelperWidgets.loadingDialog(context);
        email = await FirebaseHelper.checkUserByPhone(user.phoneNumber);
        Navigator.pop(context);
        FormHelper.setInputFieldValue(InputFieldTypes.EMAIL, email);
        isExist = email.isNotEmpty;
      } else if (user.username != null && user.username.isNotEmpty) {
        HelperWidgets.loadingDialog(context);
        email = await FirebaseHelper.checkUserByUsername(user.username);
        Navigator.pop(context);
        FormHelper.setInputFieldValue(InputFieldTypes.EMAIL, email);
        isExist = email.isNotEmpty;
      }
      if (isExist) {
        if (_isLoginAttempt && !_isForgotPassword) {
          _animatePasswordInputField();
          _currentInputController.text = '';
          setState(() {});
        } else if (!_isLoginAttempt && !_isForgotPassword) {
          _currentInputErrorText =
              'Provided ' + _currentFieldInfo.labelText + ' already in use';
          setState(() {});
          return;
        } else if (_isForgotPassword) {
          // var user = FormHelper.getCurrentUser();
          HelperWidgets.loadingDialog(context);
          var error = await FirebaseHelper.resetPasswordFirebase(email);
          Navigator.pop(context);
          if (error != null && error.isNotEmpty) {
            _currentInputErrorText = error;
            _showErrorText;
            _isForgotPassword = false;
            setState(() {});
          } else {
            _isLoginAttempt = true;
            // _scaffoldKey.currentState.showSnackBar(new SnackBar(
            //   backgroundColor: Colors.grey,
            //   content: new Text(Constants.forgotPwdCheckEmail),
            //   duration: Duration(seconds: 1),
            // ));
           SplashScreenPageState.buildScackbar(new SnackBar(
              backgroundColor: Colors.grey,
              content: new Text(Constants.forgotPwdCheckEmail),
              duration: Duration(seconds: 1),
            ));
            setState(() {});
            _isForgotPassword = false;
          }
        }

        // return;
      } else {
        if (_isLoginAttempt && !_isForgotPassword) {
          _showSignupMessage = true;
          _isLoginAttempt = false;
          setState(() {});
        } else if (_isForgotPassword) {
          _currentInputErrorText = Constants.forgotPwdEmailNotFound;
          setState(() {});
          return;
        }
      }
      // IF SIGNUP PROCESS THEN REMOVE PREFILLED INPUT
      if (user.email != null && user.email.isNotEmpty) {
        FormHelper.removeInputFieldValue(InputFieldTypes.EMAIL);
      }
      if (user.phoneNumber != null && user.phoneNumber.isNotEmpty) {
        FormHelper.removeInputFieldValue(InputFieldTypes.PHONE);
      }
    }
    if (_currentFieldInfo.type == InputFieldTypes.EMAIL) {
      bool isExistsEmail = false;
      HelperWidgets.loadingDialog(context);
      isExistsEmail = await FirebaseHelper.checkUserByEmail(value);
      if (isExistsEmail) {
        _currentInputErrorText =
            'Provided ' + _currentFieldInfo.labelText + ' already in use';
        setState(() {});
        Navigator.pop(context);
        return;
      }
      Navigator.pop(context);
    }
    if (_currentFieldInfo.type == InputFieldTypes.PHONE &&
        value != null &&
        value.isNotEmpty) {
      HelperWidgets.loadingDialog(context);
      value = await FirebaseHelper.checkUserByPhone(value);
      if (value.isNotEmpty) {
        _currentInputErrorText =
            'Provided ' + _currentFieldInfo.labelText + ' already in use';
        setState(() {});
        Navigator.pop(context);
        return;
      }
      Navigator.pop(context);
    }

    // For LOGIN process
    if (_isLoginAttempt && _currentFieldInfo.type == InputFieldTypes.PASSWORD) {
      var user = FormHelper.getCurrentUser();
      // DO LOGIN
      HelperWidgets.loadingDialog(context);
      //  var error = await _firebaseEmailLogin(user);
      var error = await FirebaseHelper.loginUserByEmailAndPassword(
          user.email, user.password);
      if (error != null && error.isNotEmpty) {
        _currentInputErrorText = error;
        _showErrorText;
        setState(() {});
        Navigator.pop(context);
        return;
      } else {
        // REDIRECT TO DASHBAORD
        Navigator.pop(context);
        _resetState();
        pushHomeScreen(user.email);
      }
    }
    if (_currentInputIndex < FormHelper.getInputFieldsCount() - 1) {
      _animateNextInput();
    } else {
      /// REGISTER
      //  var user = getUser();
      var user = FormHelper.getCurrentUser();
      HelperWidgets.loadingDialog(context);
      var error = await FirebaseHelper.signupUser(user);
      if (error != null && error.isNotEmpty) {
        _currentInputErrorText = error;
        setState(() {});
        Navigator.pop(context);
        return;
      } else {
        // REDIRECT TO DASHBAORD
        Navigator.pop(context);
        _resetState();

        pushHomeScreen(user.email);
      }
      //  _firebaseEmailSignUp(user);
    }
  }

  void _animatePasswordInputField() {
    _currentInputErrorText = '';
    FormHelper.getNextInputFieldByType(InputFieldTypes.PASSWORD);
    setState(() => {});
    _inputFocusNode.unfocus();
  }

  void _animateNextInput() {
    _currentInputErrorText = '';
    _setCurrentFieldInfo(++_currentInputIndex);

    setState(() => {});
    _inputFocusNode.unfocus();
  }

  void onInputChanged(String value) {
    if (_currentFieldInfo.type != InputFieldTypes.USERNAME_EMAIL_PHONE) {
      return;
    }
    if (value == null || value.isEmpty) {
      _currentFieldInfo.labelText = 'USERNAME EMAIL PHONE';
    } else if (value.contains('@')) {
      _currentFieldInfo.labelText = 'EMAIL';
    } else if (RegExp(Constants.regexNumber).hasMatch(value)) {
      _currentFieldInfo.labelText = 'PHONE';
    } else if (value.length <= 4) {
      _currentFieldInfo.labelText = 'USERNAME EMAIL PHONE';
    } else {
      _currentFieldInfo.labelText = 'USERNAME';
    }
    setState(() => {});
  }

//Handle will pop --end

//MAIN UI Building --start
  @override
  Widget build(BuildContext context) {
    //Assigning animations --start
    return new Material(
        color: Colors.transparent,
        child: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_focusMain);
          },
          child: _buildLogin(),
        ));
  }

//bottom Sheet --start
//bottom Sheet methods --start
  void _bottomAuthBtnClicked() {
    _resetInputUI(null);
    _showSignupMessage = false;
    _showErrorText = false;
    _currentInputErrorText = '';
    _isForgotPassword = false;
    _isLoginAttempt ? _isLoginAttempt = false : _isLoginAttempt = true;
    setState(() {});
    Navigator.pop(context);
  }

  void _bottomForgotPasswordBtnClicked() {
    _resetInputUI(null);
    _isForgotPassword = true;
    _showErrorText = false;
    _currentInputErrorText = '';
    _showSignupMessage = false;
    setState(() {});
    Navigator.pop(context);


     SplashScreenPageState.buildScackbar(new SnackBar(
                  backgroundColor: Colors.grey,
      content: new Text(Constants.forgotPwdEnterDetails),
      duration: Duration(seconds: 1),
    ));
  }

//bottom Sheet methods --end
//bootom Sheet UI--start
  void _modalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: MediaQuery.of(context).size.height / 3,
            color: Colors.white,
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new RaisedButton(
                    elevation: 12.0,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: _bottomAuthBtnClicked,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: _isLoginAttempt
                        ? new Text("Sign Up")
                        : new Text("Sign In"),
                  ),
                  new RaisedButton(
                    elevation: 12.0,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: _bottomForgotPasswordBtnClicked,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: new Text("Forgot Password"),
                  ),
                  new RaisedButton(
                    elevation: 12.0,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () {},
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: new Text("Login with OTP"),
                  ),
                ],
              ),
            ),
          );
        });
  }
//bottom Sheet --end

  Widget _buildLogin() {
    var _inputField = TextField(
      controller: _currentInputController,
      keyboardType: _currentFieldInfo.inputKeyboardType,
      obscureText: _currentFieldInfo.isObscure,
      focusNode: _inputFocusNode,
      onChanged: onInputChanged,
      onSubmitted: onInputSubmit,
      style: new TextStyle(
        fontSize: 12.0,
        color: Colors.black,
      ),
      decoration: new InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 17.0),
        prefixIcon: new IconButton(
          onPressed: null,
          icon: _currentFieldInfo.icon,
          color: Colors.black,
        ),
        labelText: _currentFieldInfo.labelText,
        labelStyle: new TextStyle(
          fontSize: 12.0,
          color: colorPasswordLabel,
        ),
        hintStyle: new TextStyle(fontSize: 10.0, color: Colors.grey),
        border: new OutlineInputBorder(
            gapPadding: 8.0,
            borderRadius: BorderRadius.circular(25.0),
            borderSide: new BorderSide(color: Colors.grey, width: 10.0)),
      ),
    );

    var errorContainer = new Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 60.0, top: 5.0, right: 60.0),
      child: _currentInputErrorText == null || _currentInputErrorText.isNotEmpty
          ? new Text(
              _currentInputErrorText,
              textAlign: TextAlign.left,
              style: new TextStyle(
                color: Colors.red,
                fontSize: 11.0,
              ),
            )
          : new Container(),
    );

    return new Container(
      color: Colors.transparent,
      child: new Column(
        children: <Widget>[
          new Expanded(
            flex: 10,
            child: new Container(),
          ),
          new Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            padding: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Container(color: Colors.white, child: _inputField),
                ),
                // )
              ],
            ),
          ),
          new Container(
            child: !_showSignupMessage
                ? new Container()
                : new Container(
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, right: 50.0),
                    child: new Text.rich(
                      new TextSpan(
                        children: <TextSpan>[
                          new TextSpan(
                            text: Constants.textSpan1,
                            style: new TextStyle(
                                fontSize: 11.0, color: Colors.red),
                          ),
                          new TextSpan(
                            text: Constants.textSpan2,
                            style: new TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          new TextSpan(
                            text: Constants.textSpan3,
                            style: new TextStyle(
                                fontSize: 11.0, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          errorContainer,
          new Expanded(
            flex: 2,
            child: new Container(),
          ),
          new Text(
            'LOGIN WITH',
            style: new TextStyle(color: Colors.grey, fontSize: 10.0),
          ),
          new Container(
            margin: EdgeInsets.only(bottom: 1.5),
          ),
          new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  child: new Container(),
                  flex: 2,
                ),
                new GestureDetector(
                  onTap: () {
                    _googleLogin();
                  },
                  child: new CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: new AssetImage('assets/google.png'),
                  ),
                ),
                new Container(
                  margin: EdgeInsets.all(5.0),
                ),
                new GestureDetector(
                    onTap: () => _facebookLogin(),
                    child: new CircleAvatar(
                      backgroundImage: new AssetImage('assets/facebook.jpg'),
                    )),
                new Container(
                  margin: EdgeInsets.all(5.0),
                ),
                new Expanded(
                  child: new Container(),
                  flex: 2,
                ),
              ],
            ),
          ),
          new Expanded(
            flex: 1,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new IconButton(
                  icon: new Image.asset(
                    'assets/bottomSheet.png',
                    color: Colors.blue,
                    fit: BoxFit.fitWidth,
                    width: 20.0,
                  ),
                  onPressed: () {
                    _modalBottomSheet();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
// UI Building end
}
