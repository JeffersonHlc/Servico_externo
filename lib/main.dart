import 'package:flutter/material.dart';
import 'telas/tela_login.dart';
import 'telas/tela_cadastro_usuario.dart';
import 'telas/tela_principal.dart';
import 'telas/tela_cadastro_produto.dart';
import 'telas/tela_consulta_produto.dart'; // Adicionada
import 'telas/tela_consulta_usuario.dart'; // Adicionada

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestão de Produtos e Usuários',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TelaLogin(),
        '/cadastro_usuario': (context) => TelaCadastroUsuario(),
        '/principal': (context) => const TelaPrincipal(),
        '/cadastro_produto': (context) => TelaCadastroProduto(),
        '/consulta_produto': (context) => const TelaConsultaProduto(), // Rota de consulta de produtos
        '/consulta_usuario': (context) => const TelaConsultaUsuario(), // Rota de consulta de usuários
      },
    );
  }
}
