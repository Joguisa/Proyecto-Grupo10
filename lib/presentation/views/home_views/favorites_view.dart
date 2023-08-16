import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
   
  const FavoritesView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Favorites View'),
      ),
      body: Center(
        child: Text('Favoritos'),
      ),
    );
  }
}