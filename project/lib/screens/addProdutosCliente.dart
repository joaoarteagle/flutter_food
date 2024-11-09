import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class addProdutosCliente extends StatefulWidget {
  @override
  _addProdutosClienteState createState() => _addProdutosClienteState();
}

class _addProdutosClienteState extends State<addProdutosCliente> {
  List produtos = [];

  Future<void> _carregarProdutos() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/produtos'));
    if (response.statusCode == 200) {
      setState(() {
        produtos = jsonDecode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fazer Pedido'),
      ),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];
          return ListTile(
            title: Text(produto['nome']),
            subtitle: Text(produto['descricao']),
            trailing: Text('R\$ ${produto['preco']}'),
            onTap: () {
              // Aqui você pode adicionar lógica para o cliente fazer o pedido desse produto
            },
          );
        },
      ),
    );
  }
}
