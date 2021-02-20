import 'package:desafiofinal_app/model/usuario.dart';

class Pedido {
  int id;
  Usuario usuario;
  var dta;

  Pedido(int id, Usuario usuario, var dta)
      : this.id = id,
        this.usuario = usuario,
        this.dta = dta;
}
