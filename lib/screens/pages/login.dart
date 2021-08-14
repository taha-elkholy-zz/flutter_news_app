import 'package:flutter/material.dart';
import 'package:news_app/api/authentication_api.dart';
import 'package:news_app/screens/home_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthenticationAPI authenticationAPI = AuthenticationAPI();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool loginError = false;

  TextEditingController _userNameController;
  TextEditingController _passwordController;

  String _userName;
  String _password;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('LOGIN'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: (isLoading) ? _drawLoading() : _drawLoginForm(),
      ),
    );
  }

  Widget _drawLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _drawLoginForm() {
    if (loginError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Login Error'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                loginError = false;
              });
            },
            child: Text(
              'Try Again',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      );
    }
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _userNameController,
              decoration: InputDecoration(labelText: 'User Name'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Your User Name';
                }
                return null;
              },
            ),
            SizedBox(
              height: 48,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Your Password';
                }
                return null;
              },
            ),
            SizedBox(
              height: 48,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    _userName = _userNameController.text;
                    _password = _passwordController.text;

                    var response =
                        await authenticationAPI.login(_userName, _password);
                    if (response) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Home();
                      }));
                    } else {
                      loginError = true;
                    }
                    setState(() {
                      isLoading = false;
                    });
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }
}
