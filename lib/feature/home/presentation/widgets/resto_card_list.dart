import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myresto/config/database_helper.dart';
import '../../../../data/models/restaurant.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/images.dart';
import '../../../../utils/styles.dart';

class RestaurantCard extends StatefulWidget {
  final Restaurant restaurant;
  final VoidCallback? onRemove;

  const RestaurantCard({
    required this.restaurant,
    this.onRemove,
    super.key,
  });

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  bool? _isWishlisted;

  @override
  void initState() {
    super.initState();
    _checkIfWishlisted();
  }

  Future<void> _checkIfWishlisted() async {
    final dbHelper = DatabaseHelper();
    final wishlist = await dbHelper.getWishlist();
    if (mounted) {
      setState(() {
        _isWishlisted = wishlist.any((r) => r.id == widget.restaurant.id);
      });
    }
  }

  void _toggleWishlist() async {
    final dbHelper = DatabaseHelper();

    if (_isWishlisted == true) {
      await dbHelper.removeRestaurant(widget.restaurant.id);
      widget.onRemove != null ? widget.onRemove!() : null;
    } else {
      await dbHelper.addRestaurant(widget.restaurant);
    }

    if (mounted) {
      setState(() {
        _isWishlisted = !_isWishlisted!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.restaurantDetail,
          arguments: {'restaurantId': widget.restaurant.id},
        );
      },
      child: Hero(
        tag: 'restaurant-${widget.restaurant.id}',
        child: Card(
          margin: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl:
                    'https://restaurant-api.dicoding.dev/images/small/${widget.restaurant.pictureId}',
                width: 150,
                height: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Image.asset(
                  Images.emptyImage,
                  width: 150,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.restaurant.name, style: semiBoldStyle),
                      const SizedBox(height: 4),
                      Text(
                        widget.restaurant.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text('Rating: ${widget.restaurant.rating}',
                          style: blackTextStyle),
                      const SizedBox(height: 4),
                      Text('Location: ${widget.restaurant.city}',
                          style: blackTextStyle),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  _isWishlisted == true
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: _isWishlisted == true ? Colors.red : Colors.grey,
                ),
                onPressed: _toggleWishlist,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
