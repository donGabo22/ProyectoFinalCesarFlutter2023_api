// lib/models/meal.dart

class Meal {
  final String id;
  final String title;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final List<String> ingredients;

  Meal({
    required this.id,
    required this.title,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    // La propiedad 'strIngredient' en la API contiene una lista de ingredientes.
    // Vamos a extraer los ingredientes de la respuesta JSON.
    final ingredients = List<String>.generate(
      20, // Número de ingredientes máximo que se pueden proporcionar en la API.
      (index) => json['strIngredient${index + 1}'] ?? '',
    ).where((ingredient) => ingredient.isNotEmpty).toList();

    return Meal(
      id: json['idMeal'] ?? '',
      title: json['strMeal'] ?? '',
      category: json['strCategory'] ?? '',
      area: json['strArea'] ?? '',
      instructions: json['strInstructions'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
      ingredients: ingredients,
    );
  }
}
