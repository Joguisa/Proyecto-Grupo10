import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_grupo10/domain/entities/actor.dart';

import 'actors_repository_provider.dart';

final actorsByMovieProvider = StateNotifierProvider< ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch( actorsRepositoryProvider );
  
  return ActorsByMovieNotifier( getActors: actorsRepository.getActorByMovie );
});
/**
 * {
 * '231241': <Actor>[],
 * '123124': <Actor>[],
 * '231241': <Actor>[],
 * '231241': <Actor>[],
 * }
 */
///

typedef GetActorsCallback = Future<List<Actor>>Function( String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {

  final GetActorsCallback getActors;

  ActorsByMovieNotifier({
    required this.getActors
  }): super({});

  Future<void> loadActors(String movieId) async {
    if( state[movieId] != null) return; //Si el estado ya tiene una película con ese id pues no hace nada, no carga una película que ya esta cargada
    
    final List<Actor> actors = await getActors( movieId );

      state = { ...state, movieId: actors };
  }
}