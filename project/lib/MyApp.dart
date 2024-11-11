import 'package:flutter/material.dart';
import 'package:project/screens/login.dart';
import 'screens/admin.dart';
import 'screens/addProdutosCliente.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery App'),
      ),
      backgroundColor: Color.fromRGBO(236, 255, 129, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child:
                    Text('Fazer Pedido', style: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminScreen()),
                    );
                  },
                  child: Text('Admin - Ver Pedidos'),
                )),
          ],
        ),
      ),
    );
  }
}
