import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_grupo10/presentation/providers/providers.dart';

import 'package:proyecto_grupo10/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}
class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();

    ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage();
    
  }

  @override
  Widget build(BuildContext context) {

    final slideShowMovies = ref.watch( moviesSlideshowProvider );

    const Center(
      child: CircularProgressIndicator(),
    );

    if( slideShowMovies.isEmpty){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        const CustomAppbar(),
        MoviesSlideshow(movies: slideShowMovies)
      ],
    );
  }
}