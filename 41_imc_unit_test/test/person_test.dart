import 'package:flutter_test/flutter_test.dart';
import 'package:imc_unit_test/person.dart';

void main() {

  final person = Person(name: 'Sabrina', age: 25, height: 1.60, weight: 48, id: '0');

  test('Imc deve ser 18.75', () {
    expect(person.imc, 18.75);
  });

  group('about isOlder | ', () {

    test('Deve ser maior de idade - para pessoa com mais de 18 anos', () {
      expect(person.isOlder, true);
    });

    test('Deve ser maior de idade - para pessoa com 18 anos', () {
      final person = Person(name: 'Sabrina', age: 18, height: 1.60, weight: 48, id: '0');
      expect(person.isOlder, true);
    });

  });

}