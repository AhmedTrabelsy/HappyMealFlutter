class Meal {
  late String id;
  late String name;
  late String image;
  late String country;
  late String price;
  late List<String>? tags;
  late String? instructions;
  late String? ingredient1;
  late String? ingredient2;
  late String? ingredient3;
  late String? measure1;
  late String? measure2;
  late String? measure3;

  Meal({
    required this.id,
    required this.name,
    required this.image,
    required this.country,
    required this.price,
    this.tags,
    this.instructions,
    this.ingredient1,
    this.ingredient2,
    this.ingredient3,
    this.measure1,
    this.measure2,
    this.measure3,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    try {
      return Meal(
        id: json['idMeal'] as String,
        name: json['strMeal'] as String,
        image: json['strMealThumb'] as String,
        country: json['strArea'] as String,
        price: json['price'] as String,
        tags: json['strTags']?.split(',') as List<String>?,
        instructions: json['strInstructions'] as String?,
        ingredient1: json['strIngredient1'] as String?,
        ingredient2: json['strIngredient2'] as String?,
        ingredient3: json['strIngredient3'] as String?,
        measure1: json['strMeasure1'] as String?,
        measure2: json['strMeasure2'] as String?,
        measure3: json['strMeasure3'] as String?,
      );
    } catch (e) {
      throw const FormatException('Failed to load Meal !');
    }
  }
}
