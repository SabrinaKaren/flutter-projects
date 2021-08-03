import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:imc_unit_test/person_repository.dart';
import 'package:mocktail/mocktail.dart';

class ClientMock extends Mock implements http.Client {}

const jsonReturn = '[{"name":"name 1","age":51,"height":20,"weight":84,"id":"1"},{"name":"name 2","age":4,"height":42,"weight":62,"id":"2"},{"name":"name 3","age":5,"height":96,"weight":25,"id":"3"},{"name":"name 4","age":38,"height":84,"weight":94,"id":"4"},{"name":"name 5","age":36,"height":33,"weight":86,"id":"5"},{"name":"name 6","age":39,"height":37,"weight":17,"id":"6"},{"name":"name 7","age":8,"height":52,"weight":18,"id":"7"},{"name":"name 8","age":35,"height":27,"weight":74,"id":"8"},{"name":"name 9","age":33,"height":4,"weight":21,"id":"9"},{"name":"name 10","age":15,"height":0,"weight":73,"id":"10"},{"name":"name 11","age":74,"height":10,"weight":75,"id":"11"},{"name":"name 12","age":33,"height":10,"weight":99,"id":"12"},{"name":"name 13","age":63,"height":29,"weight":34,"id":"13"},{"name":"name 14","age":56,"height":79,"weight":10,"id":"14"},{"name":"name 15","age":81,"height":55,"weight":20,"id":"15"},{"name":"name 16","age":59,"height":98,"weight":75,"id":"16"},{"name":"name 17","age":78,"height":18,"weight":46,"id":"17"},{"name":"name 18","age":38,"height":15,"weight":40,"id":"18"},{"name":"name 19","age":62,"height":13,"weight":33,"id":"19"},{"name":"name 20","age":25,"height":52,"weight":100,"id":"20"},{"name":"name 21","age":98,"height":10,"weight":75,"id":"21"},{"name":"name 22","age":52,"height":62,"weight":96,"id":"22"},{"name":"name 23","age":78,"height":50,"weight":20,"id":"23"},{"name":"name 24","age":1,"height":28,"weight":89,"id":"24"},{"name":"name 25","age":63,"height":22,"weight":90,"id":"25"},{"name":"name 26","age":40,"height":38,"weight":89,"id":"26"},{"name":"name 27","age":91,"height":47,"weight":37,"id":"27"},{"name":"name 28","age":77,"height":44,"weight":69,"id":"28"},{"name":"name 29","age":55,"height":2,"weight":52,"id":"29"},{"name":"name 30","age":63,"height":2,"weight":0,"id":"30"},{"name":"name 31","age":97,"height":82,"weight":85,"id":"31"},{"name":"name 32","age":41,"height":1,"weight":30,"id":"32"},{"name":"name 33","age":26,"height":94,"weight":60,"id":"33"},{"name":"name 34","age":47,"height":58,"weight":91,"id":"34"},{"name":"name 35","age":38,"height":70,"weight":27,"id":"35"},{"name":"name 36","age":81,"height":30,"weight":96,"id":"36"},{"name":"name 37","age":42,"height":68,"weight":19,"id":"37"},{"name":"name 38","age":78,"height":53,"weight":50,"id":"38"},{"name":"name 39","age":15,"height":65,"weight":19,"id":"39"},{"name":"name 40","age":29,"height":61,"weight":64,"id":"40"},{"name":"name 41","age":41,"height":0,"weight":38,"id":"41"},{"name":"name 42","age":31,"height":61,"weight":45,"id":"42"},{"name":"name 43","age":41,"height":78,"weight":48,"id":"43"},{"name":"name 44","age":78,"height":83,"weight":99,"id":"44"},{"name":"name 45","age":76,"height":86,"weight":71,"id":"45"},{"name":"name 46","age":77,"height":86,"weight":59,"id":"46"},{"name":"name 47","age":54,"height":72,"weight":37,"id":"47"},{"name":"name 48","age":24,"height":27,"weight":81,"id":"48"},{"name":"name 49","age":54,"height":58,"weight":55,"id":"49"},{"name":"name 50","age":3,"height":50,"weight":41,"id":"50"}]';

void main() {

  final client = ClientMock();

  final repository = PersonRepository(client);

  test('deve pegar uma lista de person', () async {
    when(client).calls(#get).thenAnswer((_) async => http.Response(jsonReturn, 200));
    final personList = await repository.getPerson();
    expect(personList.isNotEmpty, equals(true));
  });

  test('retorna um exception se nao for statusCode 200', () async {
    when(client).calls(#get).thenAnswer((_) async => http.Response(jsonReturn, 404));
    expect(() async => await repository.getPerson(), throwsException);
  });

}