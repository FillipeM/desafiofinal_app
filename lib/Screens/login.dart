import 'dart:ui';

import 'package:desafiofinal_app/Screens/index.dart';
import 'package:desafiofinal_app/Screens/usuario.dart';
import 'package:desafiofinal_app/services/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  var _key = GlobalKey<ScaffoldState>();
  var _showPassword = true;

  btnEntrarClick() {
    LoginService _loginService = LoginService(_userName.text, _password.text);
    _loginService.checkUser().then((value) {
      if (value == null) {
        _key.currentState.showSnackBar(SnackBar(
          content: Text(
            "Usuário não existe ou a combinação de usuário e senha está incorreta!",
            style: TextStyle(fontSize: 30),
          ),
        ));
      } else {
        _key.currentState.showSnackBar(SnackBar(
          content: Text(
            "Olá ${_userName.text}!",
            style: TextStyle(fontSize: 30),
          ),
        ));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Index(
                user: value,
              ),
            ));
      }
    });
  }

  _changePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/login.png",
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _userName,
              decoration: InputDecoration(
                hintText: "Usuário",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  child: TextField(
                    controller: _password,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _showPassword,
                    decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40))),
                  ),
                  width: 250,
                  height: 100,
                ),
                FlatButton(
                    onPressed: () {
                      _changePasswordVisibility();
                    },
                    child: Icon(_showPassword
                        ? Icons.remove_red_eye_sharp
                        : Icons.visibility_off_rounded)),
              ],
            ),
          ),
          FlatButton(
            onPressed: () => {btnEntrarClick()},
            child: Text(
              "Entrar",
              style: TextStyle(fontSize: 20),
            ),
            color: Colors.green,
            minWidth: double.infinity,
          ),
          FlatButton(
            onPressed: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Usuario()))
            },
            child: Text(
              "Novo Usuário",
              style: TextStyle(fontSize: 20),
            ),
            color: Colors.blue,
            minWidth: double.infinity,
          )
        ],
      ),
    );
  }
}
