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
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minHeight: 120,
                maxHeight: 120,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 40, left: 30),
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
              ),
            ),
            SliverToBoxAdapter(
              child: _buildList(context),
            )
          ],
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
              itemCount: snapshot.data?.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = snapshot.data?.restaurants[index];
                return CardRestaurant(restaurant: restaurant!);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Material(
                child: Text(snapshot.error.toString()),
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight > minHeight ? maxHeight : minHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
