import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/screens/pedidoScreen.dart';

void main() {
  testWidgets('Pedido screen shows product list', (WidgetTester tester) async {
    // Suponha que temos uma lista mock de produtos
    final mockProdutos = [
      {'nome': 'Produto 1', 'descricao': 'Descrição 1', 'preco': 10.0},
      {'nome': 'Produto 2', 'descricao': 'Descrição 2', 'preco': 15.0},
    ];

    // // Montar o widget PedidoScreen
    // await tester.pumpWidget(
    //   MaterialApp(home: PedidoScreen(mockProdutos: mockProdutos)),
    // );

    // Verificar se os itens da lista de produtos estão sendo exibidos
    expect(find.text('Produto 1'), findsOneWidget);
    expect(find.text('Produto 2'), findsOneWidget);

    // Verificar se os preços e descrições estão corretos
    expect(find.text('R\$ 10.0'), findsOneWidget);
    expect(find.text('R\$ 15.0'), findsOneWidget);
    expect(find.text('Descrição 1'), findsOneWidget);
    expect(find.text('Descrição 2'), findsOneWidget);
  });

  testWidgets('User can tap a product', (WidgetTester tester) async {
    final mockProdutos = [
      {'nome': 'Produto 1', 'descricao': 'Descrição 1', 'preco': 10.0},
      {'nome': 'Produto 2', 'descricao': 'Descrição 2', 'preco': 15.0},
    ];

    // await tester.pumpWidget(
    //   MaterialApp(home: PedidoScreen(mockProdutos: mockProdutos)),
    // );

    // Simular um toque em um item da lista
    await tester.tap(find.text('Produto 1'));
    await tester.pump();
  });
}
