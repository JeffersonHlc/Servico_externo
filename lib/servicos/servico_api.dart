import 'dart:convert';
import 'package:http/http.dart' as http;

class ServicoApi {
  // Função que busca produtos na API
  Future<List<dynamic>> buscarProdutos() async {
    final resposta = await http.get(Uri.parse('http://127.0.0.1:5000/produtos'));

    if (resposta.statusCode == 200) {
      // Decodifica a resposta JSON e retorna a lista de produtos
      List<dynamic> dados = jsonDecode(resposta.body);
      return dados;
    } else {
      throw Exception('Erro ao carregar produtos');
    }
  }
}
