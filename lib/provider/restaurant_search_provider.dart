
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  late RestaurantSearch _restaunrantSearch;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantSearch get result => _restaunrantSearch;

  ResultState get state => _state;

  Future<dynamic> fetchSearchRestaurant(String params) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantSearch(params);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaunrantSearch = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      String errorMessage;
      if (e is SocketException) {
        errorMessage = 'No Internet connection';
      } else if (e is HttpException) {
        errorMessage = 'Couldn\'t find the data';
      } else if (e is FormatException) {
        errorMessage = 'Bad response format';
      } else {
        errorMessage = 'Something went wrong';
      }
      return _message = errorMessage;
    }
  }
}
