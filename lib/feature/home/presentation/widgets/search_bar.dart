import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController searchController;
  final void Function(String)? onSubmitted;

  const SearchBarWidget({
    super.key,
    required this.searchController,
    required this.onSubmitted,
  });

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
          controller: searchController,
          hintText: 'Search',
          leading: const Icon(Icons.search),
          onSubmitted: onSubmitted
          // onChanged: (query) {
          //   context.read<RestaurantBloc>().add(SearchRestaurantEvent(query: query));
          // },
          ),
    );
  }
}
