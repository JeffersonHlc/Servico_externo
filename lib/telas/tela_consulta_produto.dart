import 'package:flutter/material.dart';
import 'package:servico_externo/servicos/servico_api.dart';  // Importe o arquivo servico_api.dart

class TelaConsultaProduto extends StatelessWidget {
  const TelaConsultaProduto({super.key});

  @override
  Widget build(BuildContext context) {
    final servicoApi = ServicoApi();  // Crie uma instância de ServicoApi

    return Scaffold(
      appBar: AppBar(title: const Text('Consulta de Produtos')),
      body: FutureBuilder<List<dynamic>>(
        future: servicoApi.buscarProdutos(),  // Use o método buscarProdutos
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var produto = snapshot.data![index];
                return ListTile(
                  title: Text(produto['nome']),
                  subtitle: Text('Preço: ${produto['preco']}'),
                );
              },
            );
          } else {
            return const Center(child: Text('Nenhum produto encontrado.'));
          }
        },
      ),
    );
  }
}
