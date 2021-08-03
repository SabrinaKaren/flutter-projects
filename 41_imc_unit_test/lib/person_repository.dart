import 'dart:convert';
import 'package:http/http.dart' as http;
import 'person.dart';

class PersonRepository {

  final http.Client client;

  PersonRepository(this.client);

  Future<List<Person>> getPerson() async {

    final response = await client.get(Uri.parse('https://61082472d73c6400170d3855.mockapi.io/person'));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map((e) => Person.fromJson(e)).toList();
    } else {
      throw Exception('Error na internet');
    }

  }

}