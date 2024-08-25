import 'package:flutter/material.dart';
import 'package:myresto/utils/styles.dart';
import '../../../../config/database_helper.dart';
import '../../../../data/models/restaurant.dart';
import '../../../home/presentation/widgets/resto_card_list.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late Future<List<Restaurant>> _wishlistFuture;

  @override
  void initState() {
    super.initState();
    _wishlistFuture = _fetchWishlist();
  }

  Future<List<Restaurant>> _fetchWishlist() async {
    final dbHelper = DatabaseHelper();
    return await dbHelper.getWishlist();
  }

  void _refreshWishlist() {
    setState(() {
      _wishlistFuture = _fetchWishlist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist', style: titleTextStyle),
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: _wishlistFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Your wishlist is empty.'));
          } else {
            final wishlist = snapshot.data!;

            return ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final restaurant = wishlist[index];
                return RestaurantCard(
                  restaurant: restaurant,
                  onRemove: _refreshWishlist, // Update list after removal
                );
              },
            );
          }
        },
      ),
    );
  }
}
