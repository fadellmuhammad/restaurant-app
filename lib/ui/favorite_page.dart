import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text('Favorite'),
        ),
      ),
    );
  }
}
