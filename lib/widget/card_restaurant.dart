import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  CardRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/detail_page', arguments: restaurant);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                '$imageUrl${restaurant.pictureId}',
                width: 120,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, _) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 4, bottom: 4),
                    child: Text(
                      restaurant.name,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey.shade700,
                        ),
                        Text(
                          restaurant.city,
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      Text(
                        '${restaurant.rating}',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
