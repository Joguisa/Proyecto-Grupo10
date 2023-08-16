import 'package:go_router/go_router.dart';
import 'package:proyecto_grupo10/presentation/views/views.dart';
import 'package:proyecto_grupo10/presentation/screens/screens.dart';

// late final Map<String, dynamic> params;

final appRouter = GoRouter(
  
  initialLocation: '/',
  routes: [

    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child); // luego de agregar login cambiarlo para que sea la ruta principal
      }, routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const HomeView();
          },
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

        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesView();
          },
        )
      ],
    )






    // Rutas padre/hijo
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen( childView: HomeView(),),
    //   routes: [
    //     GoRoute(
    //   path: 'movie/:id',
    //   name: MovieScreen.name,
    //   builder: (context, state) {
    //     final movieId = state.pathParameters['id'] ?? 'no-id';

    //     return MovieScreen( movieId: movieId);
    //   }
    // ),
  ]
);