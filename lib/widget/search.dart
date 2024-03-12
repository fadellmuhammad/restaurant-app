import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';

class Search extends StatefulWidget {
  final Function resultSearch;
  const Search({super.key, required this.resultSearch});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void _fetchSearch(value) {
    widget.resultSearch(
        Provider.of<RestaurantSearchProvider>(context, listen: false)
            .fetchSearchRestaurant(value));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(20),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            labelText: 'Search',
            suffixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onSubmitted: (value) => _fetchSearch(value),
        ),
      ),
    ]);
  }
}
