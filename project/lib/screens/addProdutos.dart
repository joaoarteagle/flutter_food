import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateProduto extends StatefulWidget {
  @override
  _CreateProdutoState createState() => _CreateProdutoState();
}

class _CreateProdutoState extends State<CreateProduto> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  Future<void> _adicionarProduto() async {
    final String nome = _nomeController.text;
    final double preco = double.parse(_precoController.text);
    final String descricao = _descricaoController.text;

    if (nome.isNotEmpty && preco > 0 && descricao.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://localhost:3000/produtos'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'nome': nome,
          'preco': preco,
          'descricao': descricao,
        }),
      );

      if (response.statusCode == 201) {
        // Produto adicionado com sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Produto adicionado com sucesso!')),
        );
        _nomeController.clear();
        _precoController.clear();
        _descricaoController.clear();
      } else {
        // Erro ao adicionar o produto
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao adicionar o produto!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin - Adicionar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome do Produto'),
            ),
            TextField(
              controller: _precoController,
              decoration: InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adicionarProduto,
              child: Text('Adicionar Produto'),
            ),
          ],
        ),
      ),
    );
  }
}
