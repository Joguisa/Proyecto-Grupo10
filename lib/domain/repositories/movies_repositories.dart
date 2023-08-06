import 'package:proyecto_grupo10/domain/entities/movie.dart';

//es quien va a llamar al datasource
abstract class MoviesRepository {

  Future<List<Movie>> getNowPlaying({ int page = 1 });
}