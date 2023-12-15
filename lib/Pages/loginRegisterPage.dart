import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurent_app/Services/AuthService.dart';
import 'package:rive/rive.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late String animationURL;
  Artboard? _teddyArtboard;
  SMITrigger? successTrigger, failTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? numLook;
  String? errorMessge = "";
  bool isLogged = true;
  bool passwordHidden = true;

  StateMachineController? stateMachineController;
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

  // Widget _title() {
  //   return const Text("Happy Meal Checkpoint");
  // }

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
  void initState() {
    // TODO: implement initState
    super.initState();
    animationURL = defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS
        ? 'assets/animations/login.riv'
        : 'animations/login.riv';
    rootBundle.load(animationURL).then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        stateMachineController =
            StateMachineController.fromArtboard(artboard, "Login Machine");
        if (stateMachineController != null) {
          artboard.addController(stateMachineController!);

          for (var e in stateMachineController!.inputs) {
            debugPrint(e.runtimeType.toString());
            debugPrint("name${e.name}End");
          }

          for (var element in stateMachineController!.inputs) {
            if (element.name == "trigSuccess") {
              successTrigger = element as SMITrigger;
            } else if (element.name == "trigFail") {
              failTrigger = element as SMITrigger;
            } else if (element.name == "isHandsUp") {
              isHandsUp = element as SMIBool;
            } else if (element.name == "isChecking") {
              isChecking = element as SMIBool;
            } else if (element.name == "numLook") {
              numLook = element as SMINumber;
            }
          }
        }

        setState(() => _teddyArtboard = artboard);
      },
    );
  }

  void handsOnTheEyes() {
    isHandsUp?.change(true);
  }

  void lookOnTheTextField() {
    isHandsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);
  }

  void moveEyeBalls(val) {
    numLook?.change(val.length.toDouble());
  }

  void login() {
    isChecking?.change(false);
    isHandsUp?.change(false);
    if (_controllerEmail.text == "admin" &&
        _contorllerPassword.text == "admin") {
      successTrigger?.fire();
    } else {
      failTrigger?.fire();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffd6e2ea),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_teddyArtboard != null)
                SizedBox(
                  width: 400,
                  height: 300,
                  child: Rive(
                    artboard: _teddyArtboard!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              Container(
                alignment: Alignment.center,
                width: 400,
                padding: const EdgeInsets.only(bottom: 15),
                margin: const EdgeInsets.only(bottom: 15 * 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const SizedBox(height: 15 * 2),
                          isLogged
                              ? const SizedBox()
                              : TextField(
                                  controller: _controllerName,
                                  onTap: lookOnTheTextField,
                                  onChanged: moveEyeBalls,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(fontSize: 14),
                                  cursorColor: const Color(0xffb04863),
                                  decoration: const InputDecoration(
                                    hintText: "Full Name",
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    focusColor: Color(0xffb04863),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffb04863),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: _controllerEmail,
                            onTap: lookOnTheTextField,
                            onChanged: moveEyeBalls,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(fontSize: 14),
                            cursorColor: const Color(0xffb04863),
                            decoration: const InputDecoration(
                              hintText: "Email",
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusColor: Color(0xffb04863),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffb04863),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: _contorllerPassword,
                            onTap: handsOnTheEyes,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            style: const TextStyle(fontSize: 14),
                            cursorColor: const Color(0xffb04863),
                            decoration: const InputDecoration(
                              hintText: "Password",
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusColor: Color(0xffb04863),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffb04863),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          _errorMessage(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //remember me checkbox
                              Row(
                                children: [
                                  Checkbox(
                                    value: false,
                                    onChanged: (value) {},
                                  ),
                                  const Text("Remember me"),
                                ],
                              ),
                              _sumbitButton(),
                            ],
                          ),
                          _loginOrRegisterButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





















// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   String? errorMessge = "";
//   bool isLogged = true;
//   bool passwordHidden = true;

//   final TextEditingController _controllerName = TextEditingController();
//   final TextEditingController _controllerEmail = TextEditingController();
//   final TextEditingController _contorllerPassword = TextEditingController();

//   Future<void> signInWithEmailAndPassword() async {
//     try {
//       await AuthService().signInWihEmailAndPassword(
//           email: _controllerEmail.text, password: _contorllerPassword.text);
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessge = e.message;
//       });
//     }
//   }

//   Future<void> createUserWithEmailAndPassword() async {
//     try {
//       await AuthService().createUserWithEmailAndPassword(
//           name: _controllerName.text,
//           email: _controllerEmail.text,
//           password: _contorllerPassword.text);
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessge = e.message;
//       });
//     }
//   }

//   Widget _title() {
//     return const Text("Happy Meal Checkpoint");
//   }

//   Widget _entryField(String title, TextEditingController controller) {
//     bool isPassword = false;

//     if (title.toUpperCase() == "PASSWORD") {
//       isPassword = true;
//     }

//     return TextField(
//       controller: controller,
//       obscureText: isPassword && passwordHidden,
//       decoration: InputDecoration(
//         labelText: title,
//         suffixIcon: isPassword
//             ? IconButton(
//                 icon: Icon(
//                   passwordHidden ? Icons.visibility_off : Icons.visibility,
//                   color: Theme.of(context).primaryColorDark,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     passwordHidden = !passwordHidden;
//                   });
//                 },
//               )
//             : const SizedBox(),
//       ),
//     );
//   }

//   Widget _errorMessage() {
//     return Text(
//       errorMessge == '' ? '' : 'Humm.. ! $errorMessge',
//       style: const TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
//     );
//   }

//   Widget _sumbitButton() {
//     return ElevatedButton(
//       onPressed: isLogged
//           ? signInWithEmailAndPassword
//           : createUserWithEmailAndPassword,
//       child: Text(isLogged ? "Login" : "Register"),
//     );
//   }

//   Widget _loginOrRegisterButton() {
//     return TextButton(
//       onPressed: () {
//         setState(() {
//           isLogged = !isLogged;
//         });
//       },
//       child: Text(isLogged ? "Register instead" : "Login instead"),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _title(),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(20),
//         child: Column(children: [
//           isLogged ? const SizedBox() : _entryField("Name", _controllerName),
//           _entryField("Email", _controllerEmail),
//           _entryField("Password", _contorllerPassword),
//           const SizedBox(height: 10),
//           _errorMessage(),
//           const SizedBox(height: 10),
//           _sumbitButton(),
//           _loginOrRegisterButton(),
//         ]),
//       ),
//     );
//   }
// }

//-------------------------------------------------//

