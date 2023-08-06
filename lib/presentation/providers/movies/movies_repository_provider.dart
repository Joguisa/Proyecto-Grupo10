import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_grupo10/infrastructure/datasources/moviedb_datasource.dart';
import 'package:proyecto_grupo10/infrastructure/repositories/movie_repository_impl.dart';

/**
 * Este repositorio es inmutable
 * su objetivo es proporcionar a los demás providers
 * la información necesaria para que puedan consultar
 * la información de este MovieRepositoryImpl
 */
///
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl( MoviedbDatasource() );
});
