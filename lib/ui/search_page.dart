import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';
import 'package:restaurant_app/widget/search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<RestaurantSearch> restaurant;
  bool search = false;

  void resultSearch(result) {
    setState(() {
      restaurant = result;
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
          child: Container(
            // padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Text('Search'),
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Search(resultSearch: resultSearch),
                ),
                search
                    ? Container(
                        child: _buildList(context),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future: restaurant,
      builder: (context, AsyncSnapshot<RestaurantSearch> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            if (snapshot.data!.restaurants.isEmpty) {
              return const Text('data not found');
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = snapshot.data?.restaurants[index];
                  return CardRestaurant(restaurant: restaurant!);
                },
              );
            }
          } else if (snapshot.hasError) {
            String errorMessage;
            if (snapshot.error is SocketException) {
              errorMessage = 'No Internet connection';
            } else if (snapshot.error is HttpException) {
              errorMessage = 'Couldn\'t find the data';
            } else if (snapshot.error is FormatException) {
              errorMessage = 'Bad response format';
            } else {
              errorMessage = 'Something went wrong';
            }

            return Center(
              child: Material(
                child: Text(errorMessage, textAlign: TextAlign.center),
              ),
            );
          } else {
            return const Material(child: Text(''));
          }
        }
      },
    );
  }
}
