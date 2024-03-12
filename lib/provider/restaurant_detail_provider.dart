import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState {loading, noData, hasData, error}

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  RestaurantDetailProvider({required this.apiService, required this.restaurantId}) {
    _fetchDetailRestaurant();
  }

  late RestaurantDetail _restaunrantDetail;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetail get result => _restaunrantDetail;

  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.restaurantDetail(restaurantId);
      if (restaurantDetail.restaurant == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaunrantDetail = restaurantDetail.restaurant;
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
