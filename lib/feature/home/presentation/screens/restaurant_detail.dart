import 'package:flutter/material.dart';
import '../../../../models/restaurant.dart';
import '../../../../utils/styles.dart';

class RestaurantDetail extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetail({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'restaurant-${restaurant.id}',
                child: Image.network(
                  restaurant.pictureId,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: boldStyle.copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        restaurant.description,
                        style: blackTextStyle.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Rating: ${restaurant.rating}',
                        style: blackTextStyle.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Location: ${restaurant.city}', // Added location
                        style: blackTextStyle.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Food Menu',
                        style: blackTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // 4 items per row
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio:
                              2 / 1, // Adjust aspect ratio for item size
                        ),
                        itemCount: restaurant.menus.foods.length,
                        itemBuilder: (context, index) {
                          final food = restaurant.menus.foods[index];
                          return Card(
                            elevation: 4.0,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  food.name,
                                  style: blackTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Drink Menu',
                        style: blackTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 2 / 1,
                        ),
                        itemCount: restaurant.menus.drinks.length,
                        itemBuilder: (context, index) {
                          final drink = restaurant.menus.drinks[index];
                          return Card(
                            elevation: 4.0,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  drink.name,
                                  style: blackTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
