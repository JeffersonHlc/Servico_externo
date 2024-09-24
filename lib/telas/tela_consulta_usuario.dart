import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TelaConsultaUsuario extends StatelessWidget {
  const TelaConsultaUsuario({super.key});

  Future<List<dynamic>> buscarUsuarios() async {
    final resposta = await http.get(Uri.parse('http://127.0.0.1:5000/usuarios'));

    if (resposta.statusCode == 200) {
      return jsonDecode(resposta.body);
    } else {
      throw Exception('Erro ao carregar usuários');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Usuários'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/'); // Voltar para o login
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: buscarUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var usuario = snapshot.data![index];
                return ListTile(
                  title: Text(usuario['nome']),
                  subtitle: Text(usuario['email']),
                );
              },
            );
          } else {
            return const Center(child: Text('Nenhum usuário encontrado.'));
          }
        },
      ),
    );
  }
}
