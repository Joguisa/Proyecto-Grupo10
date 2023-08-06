
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_grupo10/domain/entities/movie.dart';
import 'package:proyecto_grupo10/presentation/providers/movies/movies_repository_provider.dart';


final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref){

  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

typedef MovieCallBback = Future<List<Movie>> Function({ int page });

// StateNotifier va a pedir que tipo de estado voy a mantener dentro de el
class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currentPage = 0;
  MovieCallBback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies( page: currentPage );
    state = [...state, ...movies];
  }
  
}