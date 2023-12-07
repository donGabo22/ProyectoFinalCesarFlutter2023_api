import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:bbq_api/models/meal.dart';

class CardSwiper extends StatelessWidget {
  final List<Meal> meals;

  CardSwiper({required this.meals});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: [
                Image.network(meals[index].thumbnail),
                Text(meals[index].title),
              ],
            ),
          );
        },
        itemCount: meals.length,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}
