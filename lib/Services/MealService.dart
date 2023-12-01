import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurent_app/meal.dart';

class ApiService {
  static Future<List<Meal>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.42.162:3000/meals'));

    if (response.statusCode == 200) {
      final List<dynamic> mealListJson = jsonDecode(response.body);

      List<Meal> meals = mealListJson
          .map((mealJson) => Meal.fromJson(mealJson as Map<String, dynamic>))
          .toList();

      return meals;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

