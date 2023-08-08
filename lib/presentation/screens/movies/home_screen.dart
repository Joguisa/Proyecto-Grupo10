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
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read(topRateMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();


    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upComingMoviesProvider);
    final topRateMovies = ref.watch(topRateMoviesProvider);


    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          // title: CustomAppbar(),
          title: SafeArea(child: CustomAppbar()),

        ),
      ),
      
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            //pongo le appBar acá porque sino se desconfigura 
            // const CustomAppbar(),
            MoviesSlideshow(movies: slideShowMovies),
            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: 'En cine',
              subTitle: 'Hoy',
              loadNextPage: () =>
                  {ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()},
            ),
            MovieHorizontalListview(
              movies: upcomingMovies,
              title: 'Proximamente',
              subTitle: 'En este mes',
              loadNextPage: () =>
                  {ref.read(upComingMoviesProvider.notifier).loadNextPage()},
            ),
            MovieHorizontalListview(
              movies: popularMovies,
              title: 'Populares',
              subTitle: 'En esta semana',
              loadNextPage: () =>
                  {ref.read(popularMoviesProvider.notifier).loadNextPage()},
            ),
            MovieHorizontalListview(
              movies: topRateMovies,
              title: 'Mejor calificadas',
              subTitle: 'De todos los tiempos',
              loadNextPage: () =>
                  {ref.read(topRateMoviesProvider.notifier).loadNextPage()},
            ),
            const SizedBox(height: 10),
          ],
        );
      }, childCount: 1))
    ]);
  }
}
