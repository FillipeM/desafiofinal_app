import 'package:desafiofinal_app/components/custom_drawer.dart';
import 'package:desafiofinal_app/model/produto.dart';
import 'package:desafiofinal_app/model/usuario.dart';
import 'package:desafiofinal_app/services/cart_service.dart';
import 'package:desafiofinal_app/services/produto_service.dart';
import 'package:desafiofinal_app/util/dialog_acts.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  Usuario user = Usuario();

  Index({Key key, this.user}) : super(key: key);

  @override
  _IndexState createState() => _IndexState(user);
}

class _IndexState extends State<Index> {
  final _produtoService = ProdutoService();
  final _cartService = CartService();
  final _qtd = TextEditingController();
  final _key = GlobalKey<ScaffoldState>();
  Usuario _user = new Usuario();

  _IndexState(Usuario _user) {
    this._user = _user;
  }

  _showAlertDialog(BuildContext context, String title, Function dialogFunction,
      Produto _produto) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            children: [
              Text("Informe a quantidade"),
              TextField(
                controller: _qtd,
                keyboardType: TextInputType.number,
              )
            ],
          ),
          actions: [
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                if (!dialogFunction(_produto)) return;
                Navigator.pop(context);
              },
              color: Colors.green,
              textColor: Colors.white,
            ),
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () => Navigator.pop(context),
              color: Colors.red,
              textColor: Colors.white,
            )
          ],
        );
      },
    );
  }

  bool _addToCart(Produto _produto) {
    if (_qtd.text.isEmpty ||
        (_qtd.text.isNotEmpty && int.parse(_qtd.text) <= 0)) {
      _key.currentState.showSnackBar(
          SnackBar(content: Text("Informe uma quantidade válida!")));
      return false;
    }
    _cartService.addToCart(_user, _produto, int.parse(_qtd.text));
    _key.currentState
        .showSnackBar(SnackBar(content: Text("Item adicionado ao carrinho!")));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
          title: Text("Home"), centerTitle: true, backgroundColor: Colors.red),
      drawer: CustomDrawer(_user),
      body: Container(
        color: Colors.red,
        child: FutureBuilder<List<Produto>>(
          future: _produtoService.getProdutos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Image.network(snapshot.data[index].photoAddress),
                        Text('${snapshot.data[index].descricao}'),
                        Text(
                            'Valor: R\$${snapshot.data[index].valor.toStringAsFixed(2)}'),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: FlatButton(
                            onPressed: () {
                              _showAlertDialog(
                                  context,
                                  "Informe a quantidade",
                                  _addToCart,
                                  snapshot.data[index]);
                            },
                            color: Colors.green,
                            textColor: Colors.white,
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                Text("Adicionar ao Carrinho")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("erro: ${snapshot.error}");
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
