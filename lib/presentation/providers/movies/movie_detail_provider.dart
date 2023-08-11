import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_grupo10/domain/entities/movie.dart';

import 'movies_repository_provider.dart';

/**
 * Hay que poner este tipo <MovieMapNotifier, Map<String, Movie>>
 * para que riverpod sepa que tipo de dato es el que fluye
 * a traver del movieDetailProdiver
 *////
final movieDetailProdiver = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch( movieRepositoryProvider );
  
  return MovieMapNotifier(getMovie: movieRepository.getMovieById );
});
/**
 * {
 * '231241': Movie(),
 * '1231241': Movie(),
 * '231241': Movie(),
 * '231241': Movie(),
 * }
 */
///

typedef GetMovieCallback = Future<Movie>Function( String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {

  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie
  }): super({});

  Future<void> loadMovie(String movieId) async {
    if( state[movieId] != null) return; //Si el estado ya tiene una película con ese id pues no hace nada, no carga una película que ya esta cargada
      if (kDebugMode) {
        print('realizando petición http');
      }
      final movie = await getMovie( movieId );

      state = { ...state, movieId: movie };
  }
}