import 'package:desafiofinal_app/components/custom_drawer.dart';
import 'package:desafiofinal_app/model/cart.dart';
import 'package:desafiofinal_app/model/produto.dart';
import 'package:desafiofinal_app/model/usuario.dart';
import 'package:desafiofinal_app/services/cart_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  Usuario user = Usuario();

  CartPage({Key key, this.user}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState(user);
}

class _CartPageState extends State<CartPage> {
  Usuario _user = Usuario();
  final _cartService = CartService();

  _CartPageState(Usuario _user) {
    this._user = _user;
  }

  _showAlertDialog(BuildContext context, String title, Produto _produto) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            actions: [
              FlatButton(
                child: Text("Sim"),
                onPressed: () {
                  _cartService.removeFromCart(_user, _produto);
                  setState(() {});
                  Navigator.pop(context);
                },
                color: Colors.green,
                textColor: Colors.white,
              ),
              FlatButton(
                child: Text("Não"),
                onPressed: () => Navigator.pop(context),
                color: Colors.red,
                textColor: Colors.white,
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      drawer: CustomDrawer(_user),
      body: FutureBuilder<List<Cart>>(
        future: _cartService.getCartList(_user),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Image.network(snapshot.data[index].produto.photoAddress),
                      Text('${snapshot.data[index].produto.descricao}'),
                      Text(
                          'Valor: R\$${snapshot.data[index].produto.valor.toStringAsFixed(2)}'),
                      Text("Quantidade: ${snapshot.data[index].qtd}"),
                      FlatButton(
                        child: Row(children: [
                          Icon(Icons.remove),
                          Text("Remover item")
                        ]),
                        onPressed: () {
                          _showAlertDialog(context, "Remover Item?",
                              snapshot.data[index].produto);
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("erro ${snapshot.error}");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
