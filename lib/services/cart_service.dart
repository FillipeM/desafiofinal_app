import 'dart:convert';
import 'dart:math';

import 'package:desafiofinal_app/model/cart.dart';
import 'package:desafiofinal_app/model/produto.dart';
import 'package:desafiofinal_app/model/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  addToCart(Usuario _user, Produto _produto, int _qtd) async {
    var listCart = await getCartList(_user);
    if (listCart != null && listCart.length > 0) {
      if (listCart.where((element) => element.usuario.id == _user.id).length >
          0) {
        if (listCart
                .where((element) =>
                    element.usuario.id == _user.id &&
                    element.produto.id == _produto.id)
                .length >
            0) {
          listCart
              .where((element) =>
                  element.usuario.id == _user.id &&
                  element.produto.id == _produto.id)
              .first
              .qtd += _qtd;
        } else {
          int _maxId;
          _maxId = listCart.map<int>((e) => e.id).reduce(max);
          listCart.add(Cart(_maxId + 1, _user, _produto, _qtd));
        }
      } else {
        int _maxId;
        _maxId = listCart.map<int>((e) => e.id).reduce(max);
        listCart.add(Cart(_maxId + 1, _user, _produto, _qtd));
      }
    } else {
      listCart = new List<Cart>();
      listCart.add(Cart(1, _user, _produto, _qtd));
    }
    await setCartList(listCart);
  }

  removeFromCart(Usuario _user, Produto _produto) async {
    var _listCart = await getCartList(_user);
    if (_listCart != null && _listCart.length > 0) {
      _listCart.remove(_listCart.where((element) => element.produto.id == _produto.id).first);
      setCartList(_listCart);
    }
  }

  Future<List<Cart>> getCartList(Usuario _user, {Produto produto}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var _listCart = new List<Cart>();
    var _cartJson = sp.getString("cart");
    if (_cartJson != null && _cartJson.isNotEmpty) {
      var listJson = jsonDecode(_cartJson) as List;
      _listCart = listJson.map((e) => Cart.fromJson(e)).toList();
      _listCart =
          _listCart.where((element) => element.usuario.id == _user.id).toList();
      if (produto != null)
        _listCart =
            _listCart.where((element) => element.produto == produto).toList();
    }
    return _listCart;
  }

  setCartList(List<Cart> _listCart) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setString("cart", jsonEncode(_listCart));
  }
}
