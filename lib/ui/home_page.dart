import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';

enum ResultState { loading, nodata, hasData, error }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<RestaurantResult> _restaurant;

  @override
  void initState() {
    super.initState();
    _restaurant = ApiService().restaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 20, top: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    child:
                        const Icon(Icons.search, size: 26, color: Colors.grey),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 30, bottom: 10),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Restaurant',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'Recommendation restaurant for you!',
                    ),
                  ],
                ),
              ),
              Container(
                child: _buildList(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future: _restaurant,
      builder: (context, AsyncSnapshot<RestaurantResult> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data?.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = snapshot.data?.restaurants[index];
                return CardRestaurant(restaurant: restaurant!);
              },
            );
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

