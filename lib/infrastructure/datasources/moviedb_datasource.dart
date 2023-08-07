import 'package:dio/dio.dart';
import 'package:proyecto_grupo10/config/constants/environment.dart';
import 'package:proyecto_grupo10/domain/datasources/movies_datasource.dart';
import 'package:proyecto_grupo10/domain/entities/movie.dart';
import 'package:proyecto_grupo10/infrastructure/mappers/movie_mapper.dart';
import 'package:proyecto_grupo10/infrastructure/models/moviedb/moviedb_response.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.keyMovieDB,
        'language': 'es-ES'
      }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing',
      queryParameters: {
        'page' : page
      },
    );
    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }
}
