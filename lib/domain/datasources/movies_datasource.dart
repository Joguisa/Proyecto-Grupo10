import 'package:proyecto_grupo10/domain/entities/movie.dart';

//Son nuestros origines de datos
abstract class MoviesDatasource {

  Future<List<Movie>> getNowPlaying({ int page = 1 });
  Future<List<Movie>> getPopular({ int page = 1 });
  Future<List<Movie>> getUpComing({ int page = 1 });
  Future<List<Movie>> getTopRate({ int page = 1 });

  Future<Movie> getMovieById( String id);
}