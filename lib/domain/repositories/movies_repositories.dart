import 'package:proyecto_grupo10/domain/entities/movie.dart';

//es quien va a llamar al datasource
abstract class MoviesRepository {

  Future<List<Movie>> getNowPlaying({ int page = 1 });
  Future<List<Movie>> getPopular({ int page = 1 });
  Future<List<Movie>> getUpComing({ int page = 1 });
  Future<List<Movie>> getTopRate({ int page = 1 });
}