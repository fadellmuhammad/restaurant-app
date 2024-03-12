import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final int charLimit = 300;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  Widget _detailRestaurant(BuildContext context, restaurant) {
    String description = restaurant.description;
    String displayedText = _isExpanded || description.length <= charLimit
        ? description
        : '${description.substring(0, charLimit)}...';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurant.name,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              Image.network(
                '$imageUrl${restaurant.pictureId}',
                errorBuilder: (context, error, _) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 30, top: 30, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 4),
                            child: const Icon(
                              Icons.location_on,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${restaurant.address}, ${restaurant.city}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 4),
                            child: const Icon(
                              Icons.star,
                              size: 20,
                            ),
                          ),
                          Text(
                            '${restaurant.rating}',
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 4),
                            child: const Icon(
                              Icons.category,
                              size: 20,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                restaurant.categories
                                    .map((c) => c.name)
                                    .join(', '),
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 4),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: displayedText,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            TextSpan(
                              text: _isExpanded ? '\nRead Less' : '\nRead More',
                              style: const TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    _isExpanded = !_isExpanded;
                                  });
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20, left: 4),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: const Center(
                              child: Text(
                                'Menus',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: const Text(
                                        'Foods',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List<Widget>.generate(
                                        restaurant.menus.foods.length,
                                        (int index) {
                                          return Text(restaurant
                                              .menus.foods[index].name);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: const Text(
                                        'Drinks',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List<Widget>.generate(
                                        restaurant.menus.drinks.length,
                                        (int index) {
                                          return Text(restaurant
                                              .menus.drinks[index].name);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Customer Reviews',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: restaurant.customerReviews.map<Widget>(
                              (res) {
                                return Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(res.name),
                                      Text(res.review),
                                      Text(res.date),
                                    ],
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          var restaurant = state.result;
          return _detailRestaurant(context, restaurant);
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
