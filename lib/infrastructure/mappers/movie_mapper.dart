import 'package:proyecto_grupo10/domain/entities/movie.dart';
import 'package:proyecto_grupo10/infrastructure/models/moviedb/movie_moviedb.dart';

/**
 * El objetivo es tomar la implementación de The MovideDb y que me sirva
 * para transformarlo o acoplarlo a mi entidad
 */
///
class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
        ? 'https://image.tmdb.org/t/p/w500${ moviedb.backdropPath }'
        : 'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500${ moviedb.posterPath }'
        : 'no-poster',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount
  );
}
