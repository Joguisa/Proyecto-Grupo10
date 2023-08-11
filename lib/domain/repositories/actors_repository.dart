import 'package:proyecto_grupo10/domain/entities/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorByMovie( String movieId );
}