import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          // This is the gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),

          // This is the banner and signin box
          SingleChildScrollView(
            child: Container(
              // This container holds the rest of the things
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      // This adds spacing between banner and the signIn box
                      margin: EdgeInsets.only(bottom: 20.0),

                      // This creates the extra RED space for the title to fit in
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 55.0),

                      // Without the .. operator the .translate would return void but we want return type as Matrix4
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      // ..translate(-10.0),

                      // This gives smooth edges to the banner
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'Quinzo',
                        style: TextStyle(
                          color:
                              Theme.of(context).accentTextTheme.headline1.color,
                          fontSize: 45,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),

                  // This is the LOGIN/SIGNUP form
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'username': '',
    // 'email': '',
    'password': '',
  };

  var _isLoading = false;
  final _passwordController = TextEditingController();

  AnimationController _controller;
  Animation<Size> _heightAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _heightAnimation = Tween<Size>(
            begin: Size(double.infinity, 260), end: Size(double.infinity, 320))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _opacityAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // Method 1 for setting up animations
    // _heightAnimation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('An error occured'),
        content: Text(message),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hao theek'))
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        print('LOGIN REQUESTED');
        await Provider.of<AuthProvider>(context, listen: false).signIn(
            _authData['username'], _authData['email'], _authData['password']);
      } else {
        // Sign user up
        print('SIGNUP REQUESTED');
        await Provider.of<AuthProvider>(context, listen: false).signUp(
            _authData['username'], _authData['email'], _authData['password']);
      }
    } on HttpException catch (error) {
      print('Pakada gyi exception');
      print(error);
      _showAlert(error.toString());
      if (error.toString().contains('EMAIL_NOT_FOUND')) {
        _showAlert(
            'This email does not exists in our servers. Try signing up first.');
      }
    } catch (error) {
      _showAlert('Could not authenticate you.Please try later.');
      print(error);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    // setState(() {
    //   _authData = {
    //     'username': '',
    //     'email': '',
    //     'password': '',
    //   }; }
    // );
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final ScrollController _scrollController = ScrollController();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedBuilder(
        animation: _heightAnimation,
        builder: (ctx, ch) => Container(
            // height: _authMode == AuthMode.Signup ? 320 : 260,
            height: _heightAnimation.value.height,
            constraints: BoxConstraints(
              minHeight: _heightAnimation.value.height,
            ),
            width: deviceSize.width * 0.75,
            padding: EdgeInsets.all(16.0),
            child: ch),
        child: Form(
          key: _formKey,
          child: Scrollbar(
            controller: _scrollController,
            // isAlwaysShown: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: <Widget>[
                  // if (_authMode == AuthMode.Login)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                    // keyboardType: TextInputType.,
                    // validator: (value) {
                    //   if (value.isEmpty || value.length < 8) {
                    //     return 'Invalid email!';
                    //   }
                    // },
                    onSaved: (value) {
                      _authData['username'] = value;
                    },
                  ),
                  // if (_authMode == AuthMode.Signup)
                  //   TextFormField(
                  //     decoration: InputDecoration(labelText: 'E-Mail'),
                  //     keyboardType: TextInputType.emailAddress,
                  //     validator: (value) {
                  //       if (value.isEmpty || !value.contains('@')) {
                  //         return 'Invalid email!';
                  //       }
                  //     },
                  //     onSaved: (value) {
                  //       _authData['email'] = value;
                  //     },
                  //   ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    enableInteractiveSelection: false,
                    // initialValue: 'password',
                    controller: _passwordController,
                    // validator: (value) {
                    //   if (value.isEmpty || value.length < 5) {
                    //     return 'Password is too short!';
                    //   }
                    // },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                  if (_authMode == AuthMode.Signup)
                    FadeTransition(
                      opacity: _opacityAnimation,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration:
                            InputDecoration(labelText: 'Confirm Password'),
                        obscureText: true,
                        validator: _authMode == AuthMode.Signup
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match!';
                                }
                              }
                            : null,
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    RaisedButton(
                      child: Text(
                          _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                      onPressed: _submit,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      color: Theme.of(context).primaryColor,
                      textColor:
                          Theme.of(context).primaryTextTheme.button.color,
                    ),
                  FlatButton(
                    child: Text(
                        '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                    onPressed: _switchAuthMode,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
