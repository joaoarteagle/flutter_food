import 'package:flutter/material.dart';
import 'package:project/screens/addProdutos.dart';
import 'package:http/http.dart' as http;
import 'package:project/screens/login.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<dynamic> _pedidos = [];

  Future<void> fetchPedidos() async {
    final response = await http.get(Uri.parse('http://localhost:3000/Pedidos'));

    if (response.statusCode == 200) {
      setState(() {
        _pedidos = jsonDecode(response.body);
      });
    } else {
      throw Exception('Falha ao carregar pedidos');
    }
  }

  Future<void> pedidoFeito(int id) async {
    final response =
        await http.delete(Uri.parse('http://localhost:3000/Pedidos/$id'));
  }

  @override
  void initState() {
    super.initState();
    fetchPedidos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin - Pedidos'),
        backgroundColor: Colors.orangeAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle), // Ícone de alterar login
            onPressed: () async {
              // Apaga o estado de login do SharedPreferences
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', false);

              // Navega para a tela de login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(255, 156, 129, 1),
      body: ListView.builder(
        itemCount: _pedidos.length,
        itemBuilder: (context, index) {
          final pedido = _pedidos[index];
          return ListTile(
            title: Text('Nome: ${pedido['nome']}'),
            subtitle: Text('Endereço: ${pedido['endereco']}'),
            trailing: Text('Produto: ${pedido['produto']}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateProduto()), // Tela de criar produto
          );
        },
        child: Icon(Icons.add), // Ícone de adicionar
        tooltip: 'Adicionar Produto',
      ),
    );
  }
}
