import 'package:go_router/go_router.dart';
import 'package:proyecto_grupo10/presentation/screens/screens.dart';
late final Map<String, dynamic> params;
final appRouter = GoRouter(
  
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
      path: 'movie/:id',
      name: MovieScreen.name,
      builder: (context, state) {
        final movieId = state.pathParameters['id'] ?? 'no-id';

        return MovieScreen( movieId: movieId);
      }
    ),
      ]
    ),

    

    
  ]
);