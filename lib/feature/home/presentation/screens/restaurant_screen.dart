import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/restaurant.dart';
import '../../../../utils/styles.dart';
import '../../../core/presentation/widgets/custom_scaffold.dart';
import '../../bloc/restaurant_bloc.dart';
import '../widgets/resto_card_list.dart';
import '../widgets/search_bar.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch the list of restaurants
    context.read<RestaurantBloc>().add(GetListRestaurantEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          title: Text('List Restaurant', style: titleTextStyle),
        ),
        body: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RestaurantListSuccess) {
              return _buildRestaurantList(state.restaurantList.restaurants);
            } else if (state is RestaurantFailed) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.error),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<RestaurantBloc>()
                            .add(GetListRestaurantEvent());
                      },
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('No restaurants found'));
          },
        ));
  }

  Widget _buildRestaurantList(List<Restaurant> restaurants) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SearchBarWidget(
            searchController: _searchController,
            onSubmitted: (query) {
              context
                  .read<RestaurantBloc>()
                  .add(SearchRestaurantEvent(query: query));
            },
          ),
          if (restaurants.isEmpty)
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.7, // Adjust height as needed
              child: const Center(
                child: Text('No Restaurants Found'),
              ),
            )
          else
            ...restaurants.map((restaurant) => RestaurantCard(
                  restaurant: restaurant,
                )),
        ],
      ),
    );
  }
}
