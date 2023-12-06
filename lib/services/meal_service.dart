
import 'dart:convert';
import 'package:bbq_api/models/meal.dart';
import 'package:http/http.dart' as http;

class MealService {
  final String apiUrl = 'https://www.themealdb.com/api/json/v1/1/';

Future<List<Meal>> getMealsByCategory(String category) async {
  final response = await http.get(Uri.parse(apiUrl + 'filter.php?c=$category'));

  print('Código de respuesta: ${response.statusCode}');
  print('Cuerpo de la respuesta: ${response.body}');

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> meals = data['meals'];
    return meals.map((meal) => Meal.fromJson(meal)).toList();
  } else {
    throw Exception('Failed to load meals');
  }
}

}
