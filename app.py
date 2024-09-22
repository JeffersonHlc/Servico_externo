from flask import Flask, jsonify, request
from flask_cors import CORS

# Criação da instância do Flask
app = Flask(__name__)
CORS(app)

# Dados em memória (poderia ser substituído por um banco de dados)
usuarios = []
produtos = []

# Rota para consultar usuários
@app.route('/usuarios', methods=['GET'])
def get_usuarios():
    return jsonify(usuarios)

# Rota para cadastrar usuários
@app.route('/usuarios', methods=['POST'])
def add_usuario():
    dados = request.get_json()
    nome = dados.get('nome')
    email = dados.get('email')
    senha = dados.get('senha')

    # Verifica se o usuário já existe
    for usuario in usuarios:
        if usuario['email'] == email:
            return jsonify({'mensagem': 'Usuário já cadastrado'}), 400

    # Cadastra um novo usuário
    novo_usuario = {'nome': nome, 'email': email, 'senha': senha}
    usuarios.append(novo_usuario)
    return jsonify({'mensagem': 'Usuário cadastrado com sucesso'}), 201

# Rota para consultar produtos
@app.route('/produtos', methods=['GET'])
def get_produtos():
    return jsonify(produtos)

# Rota para cadastrar produtos
@app.route('/produtos', methods=['POST'])
def add_produto():
    dados = request.get_json()
    nome = dados.get('nome')
    preco = dados.get('preco')

    # Cadastra um novo produto
    novo_produto = {'nome': nome, 'preco': preco}
    produtos.append(novo_produto)
    return jsonify({'mensagem': 'Produto cadastrado com sucesso'}), 201

# Executa o servidor Flask
if __name__ == '__main__':
    app.run(debug=True)