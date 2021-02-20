import 'dart:convert';
import 'dart:math';

import 'package:desafiofinal_app/model/produto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProdutoService {
  final baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<Produto>> getProdutos() async {
    var response = await http.get('$baseUrl/photos');
    if (response.statusCode == 200) {
      var listJson = jsonDecode(response.body) as List;
      var randomGenerator = Random();
      var produtos = listJson
          .map((e) => Produto.fromJson(
              e, randomGenerator.nextInt(99) + randomGenerator.nextDouble()))
          .toList();
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString("produto", jsonEncode(produtos));
      return produtos;
    } else {
      throw Exception("Erro ao buscar lista de produtos");
    }
  }
}
