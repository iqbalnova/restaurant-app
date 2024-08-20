import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/presentation/widgets/custom_scaffold.dart';
import '../../../../models/restaurant.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/styles.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  late Future<List<Restaurant>> _restaurantsFuture;

  Future<List<Restaurant>> loadRestaurants() async {
    final String response =
        await rootBundle.loadString('assets/json/local_restaurant.json');
    final data = json.decode(response);
    final List<dynamic> restaurantsJson = data['restaurants'];

    return restaurantsJson.map((json) => Restaurant.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    _restaurantsFuture = loadRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(
          'List Restaurant',
          style: titleTextStyle,
        ),
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: _restaurantsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No restaurants found'));
          }

          final restaurants = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: restaurants.map((restaurant) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.restaurantDetail,
                        arguments: {'detailRestaurant': restaurant});
                  },
                  child: Hero(
                    tag: 'restaurant-${restaurant.id}',
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.network(
                            restaurant.pictureId,
                            width: 150,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurant.name,
                                    style: semiBoldStyle,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    restaurant.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Rating: ${restaurant.rating}',
                                    style: blackTextStyle,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Location: ${restaurant.city}', // Added location
                                    style: blackTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
