import 'package:desafiofinal_app/model/produto.dart';
import 'package:desafiofinal_app/model/usuario.dart';
import 'package:flutter/cupertino.dart';

class Cart {
  int id;
  Usuario usuario;
  Produto produto;
  int qtd;

  Cart(int _id, Usuario _usuario, Produto _produto, int _qtd)
      : this.id = _id,
        this.usuario = _usuario,
        this.produto = _produto,
        this.qtd = _qtd;

  Cart.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.usuario = Usuario.fromJson(json["usuario"]),
        this.produto = Produto.fromJsonWithValue(json["produto"]),
        this.qtd = json["qtd"];

  Map toJson() =>{
    'id' : this.id,
    "usuario" : this.usuario.toJson(),
    "produto" : this.produto.toJson(),
    "qtd": this.qtd
  };
}
