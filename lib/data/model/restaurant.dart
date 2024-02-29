import 'dart:convert';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;
  final Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) => Restaurant(
        id: restaurant['id'],
        name: restaurant['name'],
        description: restaurant['description'],
        pictureId: restaurant['pictureId'],
        city: restaurant['city'],
        rating: restaurant['rating'],
        menus: Menus.fromJson(restaurant['menus']),
      );
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> parsed = jsonDecode(json);
  return (parsed['restaurants'] as List)
      .map((x) => Restaurant.fromJson(x))
      .toList();
}

class Menus {
  List<MenuItem> foods;
  List<MenuItem> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> menus) => Menus(
        foods:
            (menus['foods'] as List).map((i) => MenuItem.fromJson(i)).toList(),
        drinks:
            (menus['drinks'] as List).map((i) => MenuItem.fromJson(i)).toList(),
      );
}

class MenuItem {
  String name;

  MenuItem({required this.name});

  factory MenuItem.fromJson(Map<String, dynamic> menusItem) => MenuItem(
        name: menusItem['name'],
      );
}
