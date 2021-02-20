import 'dart:convert';

import 'package:desafiofinal_app/model/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  String _nome;
  String _login;
  String _password;

  UserService(this._nome, this._login, this._password);

  Future<String> insertUsuario() async {
    var listUsuario = await getListUsuarios();
    if (listUsuario.where((element) => element.login == _login).isNotEmpty) {
      return "Já existe um usuário com este login";
    } else {
      int id = listUsuario.length == 0 ? 1 : listUsuario.last.id + 1;
      listUsuario.add(new Usuario.fromId(id, _nome, _login, _password));
      SharedPreferences _sp = await SharedPreferences.getInstance();
      _sp.setString("usuario", jsonEncode(listUsuario));
      return "Usuário $_nome criado com sucesso!";
    }
  }

  Future<List<Usuario>> getListUsuarios() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    var spUsuarios = _sp.getString("usuario");
    if (spUsuarios != null) {
      var listJson = jsonDecode(spUsuarios) as List;
      var listUsuarios = listJson.map((e) => Usuario.fromJson(e)).toList();
      return listUsuarios;
    } else {
      return new List<Usuario>();
    }
  }
}
