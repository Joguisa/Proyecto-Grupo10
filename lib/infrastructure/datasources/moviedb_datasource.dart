import 'package:dio/dio.dart';
import 'package:proyecto_grupo10/config/constants/environment.dart';
import 'package:proyecto_grupo10/domain/datasources/movies_datasource.dart';
import 'package:proyecto_grupo10/domain/entities/movie.dart';
import 'package:proyecto_grupo10/infrastructure/mappers/movie_mapper.dart';
import 'package:proyecto_grupo10/infrastructure/models/moviedb/movie_details.dart';
import 'package:proyecto_grupo10/infrastructure/models/moviedb/moviedb_response.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.keyMovieDB,
        'language': 'es-ES'
      }));

      List<Movie> _jsonToMovies( Map<String, dynamic> json){
        final movieDbResponse = MovieDbResponse.fromJson(json);

      final List<Movie> movies = movieDbResponse.results
          .where((moviedb) => moviedb.posterPath != 'no-poster')
          .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
          .toList();

      return movies;
      }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getTopRate({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getUpComing({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById( String id) async {
    final response = await dio.get('/movie/$id');
    if ( response.statusCode != 200 ) throw  Exception('Movie with id: $id not found');

    final movieDetails = MovieDetails.fromJson(response.data);

    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);

    return movie;

  }
}
