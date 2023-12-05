import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurent_app/Services/AuthService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessge = "";
  bool isLogged = true;
  bool passwordHidden = true;

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _contorllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await AuthService().signInWihEmailAndPassword(
          email: _controllerEmail.text, password: _contorllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessge = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await AuthService().createUserWithEmailAndPassword(
          name: _controllerName.text,
          email: _controllerEmail.text,
          password: _contorllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessge = e.message;
      });
    }
  }

  Widget _title() {
    return const Text("Happy Meal Checkpoint");
  }

  Widget _entryField(String title, TextEditingController controller) {
    bool isPassword = false;

    if (title.toUpperCase() == "PASSWORD") {
      isPassword = true;
    }

    return TextField(
      controller: controller,
      obscureText: isPassword && passwordHidden,
      decoration: InputDecoration(
        labelText: title,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  passwordHidden ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    passwordHidden = !passwordHidden;
                  });
                },
              )
            : const SizedBox(),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessge == '' ? '' : 'Humm.. ! $errorMessge',
      style: const TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
    );
  }

  Widget _sumbitButton() {
    return ElevatedButton(
      onPressed: isLogged
          ? signInWithEmailAndPassword
          : createUserWithEmailAndPassword,
      child: Text(isLogged ? "Login" : "Register"),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogged = !isLogged;
        });
      },
      child: Text(isLogged ? "Register instead" : "Login instead"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          isLogged ? const SizedBox() : _entryField("Name", _controllerName),
          _entryField("Email", _controllerEmail),
          _entryField("Password", _contorllerPassword),
          const SizedBox(height: 10),
          _errorMessage(),
          const SizedBox(height: 10),
          _sumbitButton(),
          _loginOrRegisterButton(),
        ]),
      ),
    );
  }
}
