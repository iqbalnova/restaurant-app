import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:myresto/data/models/restaurant_list.dart';

void main() {
  group('RestaurantList JSON Parsing', () {
    test('should parse JSON to RestaurantList object correctly', () {
      // Given JSON response
      const String jsonResponse = '''
      {
        "error": false,
        "message": "success",
        "count": 2,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet...",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          },
          {
            "id": "s1knt6za9kkfw1e867",
            "name": "Kafe Kita",
            "description": "Quisque rutrum. Aenean imperdiet...",
            "pictureId": "25",
            "city": "Gorontalo",
            "rating": 4.0
          }
        ]
      }
      ''';

      // When parsing JSON response to RestaurantList
      final restaurantList = RestaurantList.fromJson(json.decode(jsonResponse));

      // Then

      expect(restaurantList.restaurants.length, 2);

      final restaurant1 = restaurantList.restaurants[0];
      expect(restaurant1.id, "rqdv5juczeskfw1e867");
      expect(restaurant1.name, "Melting Pot");
      expect(restaurant1.description, "Lorem ipsum dolor sit amet...");
      expect(restaurant1.pictureId, "14");
      expect(restaurant1.city, "Medan");
      expect(restaurant1.rating, 4.2);

      final restaurant2 = restaurantList.restaurants[1];
      expect(restaurant2.id, "s1knt6za9kkfw1e867");
      expect(restaurant2.name, "Kafe Kita");
      expect(restaurant2.description, "Quisque rutrum. Aenean imperdiet...");
      expect(restaurant2.pictureId, "25");
      expect(restaurant2.city, "Gorontalo");
      expect(restaurant2.rating, 4.0);
    });
  });
}
