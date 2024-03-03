
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantResult _restaunrantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantResult get result => _restaunrantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurants();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaunrantResult = restaurant;
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
