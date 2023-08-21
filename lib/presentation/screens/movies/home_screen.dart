import 'package:flutter/material.dart';
import 'package:proyecto_grupo10/presentation/views/views.dart';
import 'package:proyecto_grupo10/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({
    Key? key, 
    required this.pageIndex
  }) : super(key: key);

  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(), // categorías
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar( currentIndex: pageIndex ),
    );
  }
}
