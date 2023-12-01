import 'package:restaurent_app/owner.dart';

class Dog {
  late int id;
  late String name;
  late double age;
  late String gender;
  late String color;
  late double weight;
  late String location;
  late String image;
  late String about;
  late String spec;
  late Owner owner;

  Dog({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.color,
    required this.weight,
    required this.location,
    required this.image,
    required this.about,
    required this.spec,
    required this.owner,
  });
}
