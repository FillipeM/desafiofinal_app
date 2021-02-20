import 'package:desafiofinal_app/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Usuario extends StatefulWidget {
  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool checkFields() {
    if (_nome.text.isEmpty || _login.text.isEmpty || _password.text.isEmpty) {
      _key.currentState
          .showSnackBar(SnackBar(content: Text("Informe todos os campos")));
      return false;
    }
    return true;
  }

  void onTabTapped(int index) {
    if (index == 0) {
      if (!checkFields()) return;
      var _usuarioService =
          new UserService(_nome.text, _login.text, _password.text);
      _usuarioService.insertUsuario().then((value) {
        _key.currentState.showSnackBar(SnackBar(content: Text("$value")));
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Cadastro de Usuário"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nome,
              decoration: InputDecoration(
                  hintText: "Nome",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _login,
              decoration: InputDecoration(
                  hintText: "Login",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _password,
              decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.save),
              label: "Salvar",
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.cancel),
              label: "Cancelar",
              backgroundColor: Colors.red)
        ],
      ),
    );
  }
}
