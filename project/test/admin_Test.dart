import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/screens/admin.dart';

void main() {
  testWidgets('Admin screen shows form fields and Add button',
      (WidgetTester tester) async {
    // Montar o widget AdminScreen
    await tester.pumpWidget(
      MaterialApp(home: AdminScreen()),
    );

    // Verificar se os campos de texto estão sendo exibidos
    expect(find.byType(TextField), findsNWidgets(3)); // Nome, Preço, Descrição

    // Verificar se o botão "Adicionar Produto" está presente
    expect(find.text('Adicionar Produto'), findsOneWidget);
  });

  testWidgets('Admin form accepts input and triggers submit',
      (WidgetTester tester) async {
    // Montar o widget AdminScreen
    await tester.pumpWidget(
      MaterialApp(home: AdminScreen()),
    );

    // Inserir texto nos campos de nome, preço e descrição
    await tester.enterText(find.byType(TextField).at(0), 'Produto Teste');
    await tester.enterText(find.byType(TextField).at(1), '10.0');
    await tester.enterText(
        find.byType(TextField).at(2), 'Descrição do produto');

    // Verificar se o texto foi inserido corretamente
    expect(find.text('Produto Teste'), findsOneWidget);
    expect(find.text('10.0'), findsOneWidget);
    expect(find.text('Descrição do produto'), findsOneWidget);

    // Tocar no botão "Adicionar Produto"
    await tester.tap(find.text('Adicionar Produto'));

    // Re-renderizar o widget após a interação
    await tester.pump();

    // Você pode verificar se o botão está funcionando adequadamente,
    // por exemplo, com mocks para o envio de dados, mas nesse teste
    // básico não há interação com o backend.
  });
}
