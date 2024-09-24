import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaCadastroProduto extends StatelessWidget {
  final TextEditingController _nomeProdutoController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();

  TelaCadastroProduto({super.key});

  void _cadastrarProduto(BuildContext context) async {
    String nome = _nomeProdutoController.text;
    String preco = _precoController.text;

    if (nome.isNotEmpty && preco.isNotEmpty) {
      // Envia a requisição pra cadastrar
      var url = Uri.parse('http://127.0.0.1:5000/produtos');
      var response = await http.post(url, body: jsonEncode({
        'nome': nome,
        'preco': double.parse(preco),
      }), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 201) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Produto cadastrado com sucesso!'),
            duration: Duration(seconds: 2),
          ),
        );

        _nomeProdutoController.clear();
        _precoController.clear();
      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao cadastrar o produto.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Produto')),
      backgroundColor: Colors.blueGrey[50],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeProdutoController,
              decoration: const InputDecoration(
                labelText: 'Nome do Produto',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.shopping_cart),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _precoController,
              decoration: const InputDecoration(
                labelText: 'Preço',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _cadastrarProduto(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Cadastrar Produto', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
