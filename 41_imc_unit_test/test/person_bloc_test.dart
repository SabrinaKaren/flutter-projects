import 'package:imc_unit_test/person.dart';
import 'package:imc_unit_test/person_bloc.dart';
import 'package:imc_unit_test/person_repository.dart';
import 'package:imc_unit_test/person_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class PersonRepositoryMock extends Mock implements PersonRepository {}

void main() {

  final repository = PersonRepositoryMock();
  final bloc = PersonBloc(repository);
  final person = Person(id: '1', name: 'Sabrina', age: 25, height: 1.6, weight: 48);

  test('deve retorna uma lista de person', () async {

    when(repository).calls(#getPerson).thenAnswer((_) async => <Person>[person, person]);

    bloc.add(PersonEvent.fetch);

    await expectLater(
        bloc,
        emitsInOrder([
          isA<PersonLoadingState>(),
          isA<PersonListState>(),
        ]));

  });

  test('deve disparar um error', () async {

    when(repository).calls(#getPerson).thenThrow(Exception('deu error'));

    bloc.add(PersonEvent.fetch);

    await expectLater(
        bloc,
        emitsInOrder([
          isA<PersonLoadingState>(),
          isA<PersonErrorState>(),
        ]));

  });

}