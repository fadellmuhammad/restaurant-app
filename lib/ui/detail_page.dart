import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class DetailPage extends StatefulWidget {
  final Restaurant restaurant;

  const DetailPage({super.key, required this.restaurant});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final int charLimit = 300;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String description = widget.restaurant.description;
    String displayedText = _isExpanded || description.length <= charLimit
        ? description
        : '${description.substring(0, charLimit)}...';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.restaurant.name,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // slivers: [
          // SliverToBoxAdapter(
          child: Column(
            children: [
              Image.network(
                widget.restaurant.pictureId,
                errorBuilder: (context, error, _) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 30, top: 30, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 20,
                              ),
                              Text(
                                widget.restaurant.city,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 20,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              '${widget.restaurant.rating}',
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: List<Widget>.generate(
                                        widget.restaurant.menus.foods.length,
                                        (int index) {
                                          return Text(widget.restaurant.menus
                                              .foods[index].name);
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: List<Widget>.generate(
                                        widget.restaurant.menus.drinks.length,
                                        (int index) {
                                          return Text(widget.restaurant.menus
                                              .drinks[index].name);
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
                  ],
                ),
              ),
            ],
          ),
          // ),
          // ],
        ),
      ),
    );
  }
}
