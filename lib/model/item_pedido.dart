import 'package:desafiofinal_app/model/pedido.dart';
import 'package:desafiofinal_app/model/produto.dart';

class ItemPedido {
  int id;
  Pedido pedido;
  Produto produto;
  int qtd;

  ItemPedido(int id, Pedido pedido, Produto produto, int qtd)
      : this.id = id,
        this.pedido = pedido,
        this.produto = produto,
        this.qtd = qtd;
}
