import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';
import 'package:restaurant_app/widget/search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool search = false;

  void resultSearch(result) {
    setState(() {
      search = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Restaurant'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Search(resultSearch: resultSearch),
              search
                  ? Container(
                      child: _buildList(context),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          var restaurant = state.result;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: restaurant.restaurants.length,
            itemBuilder: (context, index) {
              var res = restaurant.restaurants[index];
              return CardRestaurant(restaurant: res);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message, textAlign: TextAlign.center),
            ),
          );
        } else {
          return const Material(child: Text(''));
        }
      },
    );
  }
}
