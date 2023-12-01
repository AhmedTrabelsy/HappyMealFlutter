class Meal {
  late String id;
  late String name;
  late String image;
  late String country;
  late String price;
  late List<String>? tags;

  Meal(
      {required this.id,
      required this.name,
      required this.image,
      required this.country,
      required this.price,
      this.tags});

  factory Meal.fromJson(Map<String, dynamic> json) {
    try {
      return Meal(
        id: json['idMeal'] as String,
        name: json['strMeal'] as String,
        image: json['strMealThumb'] as String,
        country: json['strArea'] as String,
        price: json['price'] as String,
        tags: json['strTags']?.split(',') as List<String>?,
      );
    } catch (e) {
      throw const FormatException('Failed to load Meal !');
    }
  }
}
