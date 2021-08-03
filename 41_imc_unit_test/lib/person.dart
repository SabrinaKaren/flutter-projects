import 'dart:math' as math;

class Person {

  final String name;
  final int age;
  final double height;
  final double weight;
  final String id;

  Person({required this.name, required this.age, required this.height, required this.weight, required this.id});

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    name: json["name"],
    age: json["age"],
    height: json["height"] * 1.0,
    weight: json["weight"] * 1.0,
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "age": age,
    "height": height,
    "weight": weight,
    "id": id,
  };

  double get imc {
    var result = weight / math.pow(height, 2);
    result = result * 100;
    return result.roundToDouble() / 100;
  }

  bool get isOlder {
    return age >= 18 ? true : false;
  }

}
