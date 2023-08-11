import 'package:dio/dio.dart';
import 'package:proyecto_grupo10/config/constants/environment.dart';
import 'package:proyecto_grupo10/domain/datasources/actors_datasource.dart';
import 'package:proyecto_grupo10/domain/entities/actor.dart';
import 'package:proyecto_grupo10/infrastructure/mappers/actor_mapper.dart';
import 'package:proyecto_grupo10/infrastructure/models/moviedb/credits_responde.dart';

class ActorMovieDbDatasource extends ActorsDatasource {

  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.keyMovieDB,
        'language': 'es-ES'
      }));


  @override
  Future<List<Actor>> getActorByMovie(String movieId) async {
    final response = await dio.get(
      '/movie/$movieId/credits',
    );

    final castResponse =  CreditsResponse.fromJson(response.data);


    List<Actor> actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();

    return actors;
  }

}