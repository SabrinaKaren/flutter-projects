import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imc_unit_test/bloc_provider.dart';
import 'package:imc_unit_test/home_page.dart';
import 'package:imc_unit_test/person.dart';
import 'package:imc_unit_test/person_bloc.dart';
import 'package:imc_unit_test/person_repository.dart';
import 'package:mocktail/mocktail.dart';

class PersonRepositoryMock extends Mock implements PersonRepository {}

void main() {

  final repository = PersonRepositoryMock();
  final bloc = PersonBloc(repository);
  final person = Person(id: '1', name: 'Sabrina', age: 25, height: 1.6, weight: 48);

  testWidgets('Deve mostrar todos os estados na tela', (WidgetTester tester) async {

    when(repository).calls(#getPerson).thenAnswer((_) async => <Person>[person, person]);

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(
        bloc: bloc,
        child: HomePage(),
      ),
    ));

    final textButton = find.byType(TextButton);
    final loading = find.byType(CircularProgressIndicator);
    final personList = find.byType(ListView);
    
    expect(textButton, findsOneWidget);
    expect(loading, findsNothing);
    expect(personList, findsNothing);

    await tester.tap(textButton); // apertando o botao

    await tester.runAsync(() => bloc.stream.first);
    await tester.pump();
    expect(loading, findsOneWidget);
    
    await tester.runAsync(() => bloc.stream.first);
    await tester.pump();
    expect(personList, findsOneWidget);

  });

}