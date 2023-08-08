import 'package:proyecto_grupo10/domain/datasources/movies_datasource.dart';
import 'package:proyecto_grupo10/domain/entities/movie.dart';
import 'package:proyecto_grupo10/domain/repositories/movies_repositories.dart';


/**
 * Lo implemento para poder cambiar los origenes de los datos
 * de una manera más fácil
 */
///
class MovieRepositoryImpl extends MoviesRepository {

  final MoviesDatasource datasource;
  MovieRepositoryImpl(this.datasource);
  
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying( page: page);    
    
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular( page: page);
  }
  
  @override
  Future<List<Movie>> getTopRate({int page = 1}) {
    return datasource.getTopRate( page: page);
  }
  
  @override
  Future<List<Movie>> getUpComing({int page = 1}) {
    return datasource.getUpComing( page: page);
  }

}