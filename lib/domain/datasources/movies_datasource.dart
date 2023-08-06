import 'package:proyecto_grupo10/domain/entities/movie.dart';

//Son nuestros origines de datos
abstract class MoviesDatasource {

  Future<List<Movie>> getNowPlaying({ int page = 1 });
}