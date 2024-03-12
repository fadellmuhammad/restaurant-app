import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant.dart';

const String imageUrl = 'https://restaurant-api.dicoding.dev/images/medium/';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantList> restaurantList() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to load list of restaurant');
    }
  }

  Future<RestaurantSearch> restaurantSearch(String params) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$params'));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to search restaurant');
    }
  }

  Future<ResponseRestaurantDetail> restaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      return ResponseRestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to load restaurant detail');
    }
  }
}
