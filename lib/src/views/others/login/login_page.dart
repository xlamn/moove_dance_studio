import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';
import 'package:moove_dance_studio/src/constants/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics: true,
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            AppHeader(
              title: 'Login',
            ),
            SliverToBoxAdapter(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SizeConstants.large,
                    vertical: SizeConstants.mini,
                  ),
                  child: Text(
                    '(Currently only for admins)',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: SizeConstants.large,
                    vertical: SizeConstants.big),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _loginFormKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _emailTextController,
                              focusNode: _focusEmail,
                              validator: (value) => Validator.validateEmail(
                                email: value!,
                              ),
                              decoration: InputDecoration(
                                hintText: "E-Mail",
                                errorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _passwordTextController,
                              focusNode: _focusPassword,
                              obscureText: true,
                              validator: (value) => Validator.validatePassword(
                                password: value!,
                              ),
                              decoration: InputDecoration(
                                hintText: "Password",
                                errorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.go,
                              onFieldSubmitted: (_) async {
                                await logIn();
                              },
                            ),
                            SizedBox(height: 32.0),
                            _isProcessing
                                ? CircularProgressIndicator()
                                : Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await logIn();
                                          },
                                          child: Text(
                                            'Login',
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logIn() async {
    setState(() {
      _isProcessing = true;
    });

    if (_loginFormKey.currentState!.validate()) {
      User? user = await FireAuth.signInUsingEmailPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
        context: context,
      );

      setState(() {
        _isProcessing = false;
      });

      if (user != null) {
        Navigator.pop(context);
      }
    }
  }
}
