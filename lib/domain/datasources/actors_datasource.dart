import 'package:proyecto_grupo10/domain/entities/actor.dart';

abstract class ActorsDatasource {
  Future<List<Actor>> getActorByMovie( String movieId );
}
