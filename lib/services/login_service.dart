import 'dart:convert';

import 'package:desafiofinal_app/model/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  String _usuario;
  String _password;

  LoginService(this._usuario, this._password);

  Future<Usuario> checkUser() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    var _usuarioJson = _sp.getString("usuario");
    if (_usuarioJson == null || _usuarioJson.isEmpty) {
      return null;
    } else {
      var listJson = jsonDecode(_usuarioJson) as List;
      var _listUsuario = listJson.map((e) => Usuario.fromJson(e)).toList();
      if (_listUsuario
          .where((element) => element.login == _usuario && element.password == _password)
          .isNotEmpty) {
          return _listUsuario
              .where((element) => element.login == _usuario)
              .first;
      } else
        return null;
    }
  }
}
