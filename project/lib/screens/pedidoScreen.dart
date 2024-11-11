import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/screens/login.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PedidoScreen extends StatefulWidget {
  @override
  _PedidoScreenState createState() => _PedidoScreenState();
}

class _PedidoScreenState extends State<PedidoScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _produtoController = TextEditingController();

  Future<void> enviarPedido() async {
    if (_nomeController.text.isEmpty ||
        _enderecoController.text.isEmpty ||
        _produtoController.text.isEmpty) {
      return;
    }

    final pedido = {
      'nome': _nomeController.text,
      'endereco': _enderecoController.text,
      'produto': _produtoController.text,
    };

    final response = await http.post(
      Uri.parse('http://localhost:3000/Pedidos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pedido),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pedido enviado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao enviar o pedido.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fazer Pedido'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _enderecoController,
              decoration: InputDecoration(labelText: 'Endereço'),
            ),
            TextField(
              controller: _produtoController,
              decoration: InputDecoration(labelText: 'Produto'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: enviarPedido,
              child: Text('Enviar Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
