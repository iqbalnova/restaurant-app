import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myresto/feature/home/presentation/widgets/review_form.dart';
import 'package:myresto/utils/custom_snackbar.dart';

import '../../../../data/models/category.dart';
import '../../../../data/models/customer_review.dart';
import '../../../../data/models/restaurant_detail.dart';
import '../../../../utils/styles.dart';
import '../../bloc/restaurant_bloc.dart';

class RestaurantDetail extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetail({super.key, required this.restaurantId});

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  @override
  void initState() {
    super.initState();
    context
        .read<RestaurantBloc>()
        .add(GetDetailRestaurantEvent(restaurantId: widget.restaurantId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RestaurantBloc, RestaurantState>(
        listener: (context, state) {
          if (state is SubmitReviewSuccess) {
            showSnackbar(context, state.message, SnackbarType.success);
            context.read<RestaurantBloc>().add(
                GetDetailRestaurantEvent(restaurantId: widget.restaurantId));
          } else if (state is SubmitReviewFailed) {
            showSnackbar(context, 'Failed to submit review: ${state.error}',
                SnackbarType.error);
            context.read<RestaurantBloc>().add(
                GetDetailRestaurantEvent(restaurantId: widget.restaurantId));
          }
        },
        child: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RestaurantDetailSuccess) {
              return _buildRestaurantDetail(
                  state.restaurant, state is SubmitReviewLoading);
            } else if (state is RestaurantFailed) {
              return _buildErrorState(state.error);
            }
            return const Center(child: Text('No restaurants found'));
          },
        ),
      ),
    );
  }

  Widget _buildRestaurantDetail(
      RestaurantDetailModel restaurant, bool isReviewLoading) {
    final restaurantBloc = context.read<RestaurantBloc>();
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(restaurant),
        _buildRestaurantContent(
          restaurant,
          isReviewLoading,
          restaurantBloc,
        ),
      ],
    );
  }

  Widget _buildSliverAppBar(RestaurantDetailModel restaurant) {
    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'restaurant-${restaurant.id}',
          child: CachedNetworkImage(
            imageUrl:
                'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Image.asset(
              'assets/images/placeholder.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantContent(RestaurantDetailModel restaurant,
      bool isReviewLoading, RestaurantBloc restaurantBloc) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRestaurantTitle(restaurant),
                _buildRestaurantDescription(restaurant),
                _buildRating(restaurant),
                _buildLocation(restaurant),
                _buildFoodMenu(restaurant),
                _buildDrinkMenu(restaurant),
                _buildCustomerReviews(restaurant.customerReviews),
                ReviewForm(
                  restaurantId: restaurant.id,
                  isLoading: isReviewLoading,
                  restaurantBloc: restaurantBloc,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantTitle(RestaurantDetailModel restaurant) {
    return Text(
      restaurant.name,
      style: boldStyle.copyWith(fontSize: 24),
    );
  }

  Widget _buildRestaurantDescription(RestaurantDetailModel restaurant) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          restaurant.description,
          style: blackTextStyle.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildRating(RestaurantDetailModel restaurant) {
    return Column(
      children: [
        Text(
          'Rating: ${restaurant.rating}',
          style: blackTextStyle.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildLocation(RestaurantDetailModel restaurant) {
    return Column(
      children: [
        Text(
          'Location: ${restaurant.city}',
          style: blackTextStyle.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFoodMenu(RestaurantDetailModel restaurant) {
    return Column(
      children: [
        Text(
          'Food Menu',
          style: blackTextStyle.copyWith(
              fontSize: 20, fontWeight: FontWeight.bold),
        ),
        _buildMenuGrid(restaurant.menus.foods),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDrinkMenu(RestaurantDetailModel restaurant) {
    return Column(
      children: [
        Text(
          'Drink Menu',
          style: blackTextStyle.copyWith(
              fontSize: 20, fontWeight: FontWeight.bold),
        ),
        _buildMenuGrid(restaurant.menus.drinks),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCustomerReviews(List<CustomerReview> reviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer Reviews',
          style: blackTextStyle.copyWith(
              fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ..._buildReviewList(reviews),
      ],
    );
  }

  List<Widget> _buildReviewList(List<CustomerReview> reviews) {
    return reviews.map((review) {
      return ListTile(
        title: Text(review.name, style: boldStyle),
        subtitle: Text(review.review),
        trailing: Text(review.date, style: blackTextStyle),
      );
    }).toList();
  }

  Widget _buildMenuGrid(List<Category> menuItems) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 2 / 1,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return Card(
          elevation: 4.0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.name,
                style: blackTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<RestaurantBloc>().add(
                  GetDetailRestaurantEvent(restaurantId: widget.restaurantId));
            },
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }
}
