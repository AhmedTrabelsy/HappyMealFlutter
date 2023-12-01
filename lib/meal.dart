class Meal {
  late String id;
  late String name;
  late String image;

  Meal({required this.id, required this.name, required this.image});

  factory Meal.fromJson(Map<String, dynamic> json) {
    try {
      return Meal(
        id: json['idMeal'] as String,
        name: json['strMeal'] as String,
        image: json['strMealThumb'] as String,
      );
    } catch (e) {
      throw const FormatException('Failed to load Meal !');
    }
  }
}
