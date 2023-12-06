// meal_service.dart
import 'dart:convert';
import 'package:bbq_api/models/meal.dart';
import 'package:http/http.dart' as http;

class MealService {
  final String apiUrlBase = 'https://www.themealdb.com/api/json/v1/1/';

  Future<List<Meal>> getMealsByCategoryAndArea({
    required String category,
    required String area,
  }) async {
    String apiUrl;

    if (area == 'Any') {
      apiUrl = '$apiUrlBase/filter.php?c=$category';
    } else {
      apiUrl = '$apiUrlBase/filter.php?c=$category&a=$area';
    }

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> meals = data['meals'];
      return meals.map((meal) => Meal.fromJson(meal)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

  Future<List<String>> getAreasList() async {
    final response = await http.get(Uri.parse('$apiUrlBase/list.php?a=list'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> areas = data['meals'];
      return areas.map((area) => area['strArea'] as String).toList();
    } else {
      throw Exception('Failed to load areas list');
    }
  }
}
