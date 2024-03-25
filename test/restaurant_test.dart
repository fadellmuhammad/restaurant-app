import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

void main() {
  group('Restaurant Parsing Test: ', () {
    test('Test parsing JSON to Restaurant object', () {
      // Sample JSON data
      final json = '''
        {
          "id": "1",
          "name": "Restaurant A",
          "description": "This is a restaurant",
          "pictureId": "12345",
          "city": "City A",
          "rating": 4.5
        }
      ''';

      // Parse JSON to Restaurant object
      final restaurant = Restaurant.fromJson(jsonDecode(json));

      // Verify the parsed values
      expect(restaurant.id, '1');
      expect(restaurant.name, 'Restaurant A');
      expect(restaurant.description, 'This is a restaurant');
      expect(restaurant.pictureId, '12345');
      expect(restaurant.city, 'City A');
      expect(restaurant.rating, 4.5);
    });

    test('Test parsing JSON to RestaurantList object', () {
      // Sample JSON data
      final json = '''
        {
          "error": false,
          "message": "Success",
          "count": 2,
          "restaurants": [
            {
              "id": "1",
              "name": "Restaurant A",
              "description": "This is a restaurant",
              "pictureId": "12345",
              "city": "City A",
              "rating": 4.5
            },
            {
              "id": "2",
              "name": "Restaurant B",
              "description": "This is another restaurant",
              "pictureId": "67890",
              "city": "City B",
              "rating": 4.2
            }
          ]
        }
      ''';

      // Parse JSON to RestaurantList object
      final restaurantList = RestaurantList.fromJson(jsonDecode(json));

      // Verify the parsed values
      expect(restaurantList.error, false);
      expect(restaurantList.message, 'Success');
      expect(restaurantList.count, 2);
      expect(restaurantList.restaurants.length, 2);

      // Verify the parsed Restaurant objects
      expect(restaurantList.restaurants[0].id, '1');
      expect(restaurantList.restaurants[0].name, 'Restaurant A');
      expect(restaurantList.restaurants[0].description, 'This is a restaurant');
      expect(restaurantList.restaurants[0].pictureId, '12345');
      expect(restaurantList.restaurants[0].city, 'City A');
      expect(restaurantList.restaurants[0].rating, 4.5);

      expect(restaurantList.restaurants[1].id, '2');
      expect(restaurantList.restaurants[1].name, 'Restaurant B');
      expect(restaurantList.restaurants[1].description, 'This is another restaurant');
      expect(restaurantList.restaurants[1].pictureId, '67890');
      expect(restaurantList.restaurants[1].city, 'City B');
      expect(restaurantList.restaurants[1].rating, 4.2);
    });
  });
}
